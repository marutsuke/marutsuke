# frozen_string_literal: true

module SessionsHelper
  def teacher_log_in(teacher)
    session[:teacher_id] = teacher.id
  end

  def user_log_in(user)
    session[:user_id] = user.id
  end

  def remember_user(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:user_remember_token] = user.user_remember_token
  end

  def forget_user(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:user_remember_token)
  end

  def user_log_out
    forget_user(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:user_remember_token])
        user_log_in(user)
        @current_user = user
      end
    end
  end
end
