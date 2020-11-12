# frozen_string_literal: true

module UserSessionsHelper

  def user_log_in_without_school(user)
    session[:user_id] = user.id
    session.delete(:user_authentication_id)
    @current_user_authentication = nil
  end


  def user_log_in(user, school)
    return unless user.school_ids.include?(school.id)
    return unless user.school_users.find_by(school_id: school.id).activated

    session[:user_id] = user.id
    session[:school_id] = school.id
    cookies.permanent.signed[:school_id] = school.id
    session.delete(:user_authentication_id)
    @current_user_authentication = nil
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
    if school_id = session[:school_id]
      @current_school ||= current_user.schools.find_by(id: school_id)
    elsif school_id = cookies.signed[:school_id]
      @current_school ||= current_user.schools.find_by(id: school_id)
    end
  end
end
