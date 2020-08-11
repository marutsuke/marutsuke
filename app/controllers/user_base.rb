# frozen_string_literal: true

class UserBase < ApplicationController
  include UserSessionsHelper
  before_action :user_login_required

  layout 'layouts/user_layout'

  private

  def user_login_required
    unless current_user
      store_location
      flash[:info] = 'ログインしてください'
      if school = School.find_by(id: cookies.signed[:school_id])
        redirect_to school_login_path(login_path: school.login_path)
      else
        raise LoginRequired
      end
    end
  end
end
