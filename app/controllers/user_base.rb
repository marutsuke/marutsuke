# frozen_string_literal: true

class UserBase < ApplicationController
  include UserSessionsHelper
  include UserAuthenticationSessionsHelper
  before_action :user_login_required, :school_select_required

  layout 'layouts/user_layout'

  private

  def user_login_required
    unless current_user
      store_location
      flash[:info] = 'ログインしてください'
      redirect_to new_user_path
    end
  end

  def school_select_required
    flash[:info] = '学校を選択してください'
    redirect_to school_users_path if current_school.nil?
  end
end
