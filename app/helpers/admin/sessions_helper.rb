module Admin::SessionsHelper
  def admin_log_in(admin)
    session[:admin_id] = admin.id
  end

  def remember_admin(admin)
    admin.remember
    cookies.permanent.signed[:admin_id] = admin.id
    cookies.permanent[:admin_remember_token] = admin.admin_remember_token
  end

  def forget_admin(admin)
    admin.forget
    cookies.delete(:admin_id)
    cookies.delete(:admin_remember_token)
  end

  def admin_log_out
    forget_admin(current_admin)
    session.delete(:admin_id)
    @current_admin = nil
  end

  def current_admin
    if admin_id = session[:admin_id]
      @current_admin ||= Admin.find_by(id: admin_id)
    elsif admin_id = cookies.signed[:admin_id]
      admin = Admin.find_by(id: admin_id)
      if admin&.authenticated?(cookies[:admin_remember_token])
        admin_log_in(admin)
        @current_admin = admin
      end
    end
  end


end
