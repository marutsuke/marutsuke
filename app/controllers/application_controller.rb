# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :user_login_required

  class Forbidden < ActionController::ActionControllerError; end
  class LoginRequired < ActionController::ActionControllerError; end
  include ErrorHandlers if Rails.env.production?

  private

  def user_login_required
    unless current_user
      flash[:info] = 'ログインしてください'
      raise LoginRequired
    end
  end
end
