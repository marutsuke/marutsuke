# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :user_login_required

  def new
    @school = School.find_by(login_path: params[:login_path])
    raise ActiveRecord::RecordNotFound unless @school
  end

  def create
    @school = School.find_by(login_path: session_params[:school_login_path])
    user = search_user_from_email_or_login_id(@school)
    if user&.authenticate(session_params[:password])
      user_log_in(user)
      login_count_up(user)
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      flash[:success] = "#{user.name}さん、こんにちは!"
      redirect_to root_path
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
    @school = current_school
    user_log_out
    flash[:danger] = 'ログアウトしました。'
    redirect_to school_login_path(@school.login_path)
  end

  private

  def session_params
    params.require(:session)
          .permit(:password, :email_or_login_id, :school_login_path)
  end

  def login_count_up(user)
    login_count = user.login_count + 1
    user.update_attribute(:login_count, login_count)
  end

  def search_user_from_email_or_login_id(school)
    return nil if school.nil?

    user = school.users.find_by(login_id: session_params[:email_or_login_id]) ||
           school.users.find_by(email: session_params[:email_or_login_id])
    user
  end
end
