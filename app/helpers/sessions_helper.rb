# frozen_string_literal: true

module SessionsHelper

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def teacher_store_location
    session[:teacher_forwarding_url] = request.original_url if request.get?
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def teacher_redirect_back_or(default)
    redirect_to(session[:teacher_forwarding_url] || default)
    session.delete(:teacher_forwarding_url)
  end

end
