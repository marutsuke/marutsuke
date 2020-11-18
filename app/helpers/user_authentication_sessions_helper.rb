# frozen_string_literal: true

module UserAuthenticationSessionsHelper
  def user_authentication_login(user_authentication)
    session[:user_authentication_id] = user_authentication.id
  end

  def current_user_authentication
    if user_authentication_id = session[:user_authentication_id]
      @current_user_authentication = UserAuthentication.find_by(id: user_authentication_id)
    end
  end

  def logout_user_authentication
    session.delete(:user_authentication_id)
    @current_user_authentication = nil
  end
end
