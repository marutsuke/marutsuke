# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @email_login = params[:email].present?
  end

  def create
    user = User.find_by(login_id: session_params[:login_id])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      login_count_up(user)
      redirect_to root_path, notice: "#{user.name}さん、こんにちは！"
    else
      render :new, notice: 'ログインに失敗しました。'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:login_id, :password)
  end

  def login_count_up(user)
    login_count = user.login_count + 1
    user.update_attribute(:login_count, login_count)
  end
end
