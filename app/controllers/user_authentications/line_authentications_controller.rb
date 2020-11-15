class UserAuthentications::LineAuthenticationsController < UserBase
  skip_before_action :user_login_required, :school_select_required
  before_action :user_log_out_required
  before_action :user_authentication_login_required, only: %i[line_logged_in user_form create_user]

  # users/newでlineのボタンを押した時のアクション
  def line_authentication
    @user_authentication = UserAuthentication.new(provider: 'line')
    if @user_authentication.save
      user_authentication_login(@user_authentication)
      @user_authentication.authentication_token_save
      state = @user_authentication.authentication_token
      redirect_to line_authorize_request_url(state: state, redirect_uri: sign_up_redirect_uri)
    else
      flash[:danger] = '不正なリクエストです。'
      redirect_to users_new_path
    end
  end

  # lineでログイン後の認証画面
  # 既に登録があるかないか判断して、ログインor新規を判断。
  def line_logged_in
    return if sign_up_fail?

    if current_user_authentication.user_authenticated?(params[:state])
      line_user_id = get_line_user_id(redirect_uri: sign_up_redirect_uri, code: params[:code])
      old_user_authentication_login(line_user_id)
      if user = current_user_authentication&.user
        flash[:info] = 'ログインしました。'
        user_log_in_without_school(user)
        redirect_to root_path
      else
        @user = User.new(name: '')
        if current_user_authentication.uid.present?
          flash[:info] = 'プロフィールを入力してね'
          redirect_to user_form_user_authentications_line_authentications_path
        else
          current_user_authentication.update(uid: line_user_id)
          flash[:success] = 'LINE登録に成功しました！ようこそ！プロフィールを入力してね'
          redirect_to user_form_user_authentications_line_authentications_path
        end
      end
    else
      flash[:danger] = 'LINE登録に失敗しました。ごめんね。'
      redirect_to new_users_path
    end
  end

  # lineからの新規登録で、user登録する時
  def user_form
    new_user_permission_check #ユーザー登録後に直アクセスでuserフォームにアクセスされない
    @user = User.new(name: '')
  end

  # userの新規登録
  def create_user
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
      render :user_form
    end
  end

  private

  def old_user_authentication_login(line_user_id)
    if old_user_authentication = UserAuthentication.find_by(uid: line_user_id, provider: 'line')
      user_authentication_login(old_user_authentication)
    end
  end

  def new_user_permission_check
    if user = current_user_authentication&.user
      user_log_in_without_school(user)
      redirect_to root_path
    end
  end

  def sign_up_fail?
    if params[:error].present?
      flash[:danger] = 'LINE通知を拒否しました。'
      redirect_to new_users_path
      return true
    end
  end

  def user_params
    params.require(:user).permit(:name, :name_kana, :birth_day, :school_grade, :email)
  end

  def user_authentication_login_required
    unless current_user_authentication
      redirect_to root_path
    end
  end
end
