module RequestSpecHelper

  def admin_log_in
    admin = create(:admin)
    session_params = { email: admin.email, password: admin.password }
    post admin_login_path, params: { session: session_params }
  end

  def teacher_log_in
    teacher = create(:teacher)
    session_params = { email: teacher.email, password: teacher.password }
    post teacher_login_path, params: { session: session_params }
  end
end
