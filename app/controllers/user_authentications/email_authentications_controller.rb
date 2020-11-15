class UserAuthentications::EmailAuthenticationsController < UserBase
  skip_before_action :user_login_required, :school_select_required
  before_action :user_log_out_required

  #メールアドレスを入力するところ
  def new
    @user_authentication = UserAuthentication.new
  end

  # 既にメールアドレスが登録済みか、アカウントを持っているか、新規か判断して、アクティベーションメールを送る。
  def create
    @user_authentication = UserAuthentication.new(user_authentication_params)
    @user_authentication.provider = 'email'

    if @old_user_authentication = UserAuthentication.find_by(provider: 'email', uid: @user_authentication.uid)
      if @old_user_authentication.user_id.present?
        flash[:danger] = '入力されたメールアドレスは、既に登録されています。ログインしてください。'
        redirect_to new_user_path
      else
        @old_user_authentication.authentication_token_save
        @old_user_authentication.send_activation_mail
        flash[:success] = "#{ @old_user_authentication.uid }に再度メールを送りました！確認してください！"
        redirect_to new_user_authentications_email_authentication_path
      end
    else
      if @user_authentication.save
        @user_authentication.authentication_token_save
        @user_authentication.send_activation_mail
        flash[:success] = "#{ @user_authentication.uid }にメールを送りました!確認してください！"
        redirect_to new_user_authentications_email_authentication_path
      else
        flash[:danger] = 'エラー：入力頂いたメールアドレスにメールを送れませんでした。'
        redirect_to new_user_authentications_email_authentication_path
      end
    end
  end

  # アクティベーションする。アクティベーション期限を設けたい。
  def user_form
    @user_authentication = UserAuthentication.find_by(provider: 'email', uid: params[:uid])
    #既にユーザー登録が済んでいる場合
    if @user_authentication&.user_id.present?
      flash[:danger] = '既にアカウントが存在しています。ログインしてくださいね。'
      redirect_to new_user_path
    end

    # アクティベーションが終わってる時
    if @user_authentication&.user_authenticated?(params[:token])
      user_authentication_login(@user_authentication)
      @user = User.new(name: '', school_grade: '')
    else
      flash[:danger] = '有効なURLではありません。'
      redirect_to new_user_path
    end
  end

  # userの新規登録
  def create_user
    @user = User.new(user_params)
    if @user.save(context: :email_authentication)
      if current_user_authentication.update(user_id: @user.id)
        user_log_in_without_school(@user)
        flash[:success] = '登録完了しました！校舎に招待コードを送ってください!'
        redirect_to new_school_user_path
      else
        flash[:danger] = 'エラーです。'
        raise ''
      end
    else
      render :user_form
    end
  end

  private

  def user_authentication_params
    params.require(:user_authentication).permit(:uid)
  end

  def user_params
    params.require(:user).permit(:name, :name_kana, :birth_day, :school_grade, :password, :password_confirmation)
  end
end
