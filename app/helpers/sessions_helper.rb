module SessionsHelper
  def teacher_log_in(teacher)
    session[:teacher_id] = teacher.id
  end

end
