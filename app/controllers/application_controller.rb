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
      if school = School.find_by(id: cookies.signed[:school_id])
        redirect_to school_login_path(login_path: school.login_path)
      else
        raise LoginRequired
      end
    end
  end
end
