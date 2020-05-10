# frozen_string_literal: true

module RequestSpecHelper
  def admin_log_in
    admin = create(:admin)
    session_params = { email: admin.email, password: admin.password }
    post admin_login_path, params: { session: session_params }
  end

  def admin_log_out
    delete admin_logout_path
  end

  def teacher_log_in(teacher = nil)
    teacher ||= create(:teacher)
    session_params = { email: teacher.email, password: teacher.password }
    post teacher_login_path, params: { session: session_params }
  end

  def teacher_log_out
    delete teacher_logout_path
  end
end
