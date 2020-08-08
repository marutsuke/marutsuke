# frozen_string_literal: true

module SessionsHelper
  def teacher_log_in(teacher)
    session[:teacher_id] = teacher.id
  end

  def user_log_in(user, school)
    return unless user.school_ids.include?(school.id)

    session[:user_id] = user.id
    cookies.permanent.signed[:school_id] = school.id
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
      school_id = cookies.signed[:school_id]
      school = user&.schools&.find_by(id: school_id)
      if user&.authenticated?(cookies[:user_remember_token])
        user_log_in(user, school)
        @current_user = user
      end
    end
  end

  def current_school
    @current_school = current_user.schools.find_by(id: cookies.signed[:school_id])
    end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

end
