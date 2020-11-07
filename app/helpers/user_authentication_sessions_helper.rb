# frozen_string_literal: true

module UserAuthenticationSessionsHelper
  def save_and_set_id_at_session(user_authentication)
    result = user_authentication.save
    session[:user_authentication_id] = user_authentication.id
    result
  end
end
