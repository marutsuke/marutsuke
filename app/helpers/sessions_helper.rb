# frozen_string_literal: true

module SessionsHelper
  def teacher_log_in(teacher)
    session[:teacher_id] = teacher.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
