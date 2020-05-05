# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @email_login = params[:email].present?
  end

  def create
    user = search_user_from_email_or_login_id
    if user&.authenticate(session_params[:password])
      user_log_in(user)
      login_count_up(user)
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      redirect_to root_path, notice: "#{user.name}さん、こんにちは！"
    else
      flash.now[:danger] = if session_params[:email].present?
                             'メールアドレスまたはパスワードが間違っています'
                           else
                             'ログインIDまたはパスワードが間違っています'
                           end
      render :new
    end
  end

  def destroy
    user_log_out(user)
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:login_id, :password, :email)
  end

  def login_count_up(user)
    login_count = user.login_count + 1
    user.update_attribute(:login_count, login_count)
  end

  def search_user_from_email_or_login_id
    if session_params[:login_id].present?
      User.find_by(login_id: session_params[:login_id])
    elsif session_params[:email].present?
      User.find_by(email: session_params[:email])
    end
  end
end
