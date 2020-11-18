# frozen_string_literal: true

class SessionsController < UserBase
  skip_before_action :user_login_required, :school_select_required

  def new
  end

  def create
    user = UserAuthentication.find_by(provider: 'email', uid: session_params[:email])&.user
    if user&.authenticate(session_params[:password])
      user_log_in_without_school(user)
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      flash[:success] = "#{user.name}さん、こんにちは!"
      redirect_back_or root_path
    else
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています。'
      render :new
    end
  end

  def destroy
    @school = current_school
    user_log_out
    flash[:danger] = 'ログアウトしました。'
    redirect_to new_user_path
  end

  private

  def session_params
    params.require(:session)
          .permit(:password, :email)
  end
end
