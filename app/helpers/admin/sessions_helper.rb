module Admin::SessionsHelper
  def admin_log_in(admin)
    session[:admin_id] = admin.id
  end

  def remember(admin)
    admin.remember
    cookies.permanent.signed[:admin_id] = admin.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def admin_log_out
    session.delete(:admin_id)
    @current_admin = nil
  end

  def current_admin
    if admin_id = session[:admin_id]
      @current_admin ||= Admin.find_by(id: admin_id)
    elsif admin_id = cookies.signed[:admin_id]
      admin = Admin.find_by(id: admin_id)
      if admin&.authenticated?(cookies[:remember_token])
        admin_log_in(admin)
        @current_admin = admin
      end
    end
  end


end
