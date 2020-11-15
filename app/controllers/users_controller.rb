# frozen_string_literal: true

class UsersController < UserBase
  skip_before_action :user_login_required,
                     :school_select_required,
                     only: %i[new
                              new_line_form
                              create_by_line_form
                              mypage
                              new_authentication_form_by_email
                              create_user_authentication_by_email
                            ]
  before_action :user_log_out_required,
                only: %i[new
                         new_line_form
                         create_by_line_form
                         new_authentication_form_by_email
                         create_user_authentication_by_email
                        ]
  before_action :new_user_permission_check, only: [:new_line_form]

  def mypage; end

  def change_school
    school = current_user.schools.find(params[:school_id])
    user_log_in(current_user, school)
    flash[:success] = "#{school.name}に切り替えました"
    redirect_to root_path
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "更新しました。"
      redirect_to mypage_users_path
    else
      flash[:success] = '更新に失敗しました'
      render :mypage
    end
  end

  def new
    @user = User.new
  end

  def new_authentication_form_by_email
    @user_authentication = UserAuthentication.new
  end

  def create_user_authentication_by_email
    @user_authentication = UserAuthentication.new(user_authentication_params)
    @user_authentication.provider = 'email'

    if @old_user_authentication = UserAuthentication.find_by(provider: 'email', uid: @user_authentication.uid)
      if @old_user_authentication.user_id.present?
        flash[:danger] = '入力されたメールアドレスは、既に登録されています。ログインしてください。'
        redirect_to new_users_path
      else
        @old_user_authentication.authentication_token_save
        @old_user_authentication.send_activation_mail
        flash[:success] = '入力頂いたメールアドレスにメールを送りました。メールを確認してください。'
        redirect_to new_authentication_form_by_email_users_path
      end
    else
      if @user_authentication.save
        @user_authentication.authentication_token_save
        @user_authentication.send_activation_mail
        flash[:success] = '入力頂いたメールアドレスにメールを送りました。メールを確認してください。'
        redirect_to new_authentication_form_by_email_users_path
      else
        flash[:danger] = 'エラー：入力頂いたメールアドレスにメールを送れませんでした。'
        redirect_to new_authentication_form_by_email_users_path
      end
    end
  end

  def new_line_form
    new_user_permission_check
    @user = User.new(name: '')
  end

  def create_by_line_form
    @user = User.new(user_params)
    if @user.save
      if current_user_authentication.update(user_id: @user.id)
        user_log_in_without_school(@user)
        flash[:success] = '登録完了しました！校舎に招待コードを送ってください!'
        redirect_to new_school_user_path
      else
        flash[:danger] = 'エラーです。'
        raise 'user_has_many_user_authentication'
      end
    else
      render :new_line_form
    end
  end

  private
  def user_params
    params.require(:user).permit(:image, :name, :name_kana, :email, :birth_day, :school_grade)
  end

  def user_authentication_params
    params.require(:user_authentication).permit(:uid)
  end

  def new_user_permission_check
    if user = current_user_authentication&.user
      user_log_in_without_school(user)
      redirect_to root_path
    end
  end

  def email_already_exist(email)
    UserAuthentication.find_by(uid: email, provider: 'email')
  end
end
