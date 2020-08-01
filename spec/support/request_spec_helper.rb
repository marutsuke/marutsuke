# frozen_string_literal: true

module RequestSpecHelper
  def user_log_in(user = nil, school = nil)
    user ||= create(:user)
    school ||= user.schools.first
    session_params = { email_or_login_id: user.email, password: user.password, school_login_path: school.login_path }
    post login_post_path(school.login_path), params: { session: session_params }
  end

  def user_log_out
    delete logout_path
  end

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
