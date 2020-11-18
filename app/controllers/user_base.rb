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
    if current_school.nil? & current_user
      if current_user.school_users.size == 1
        user_log_in(current_user, current_user.schools.first)
        redirect_to root_path
      else
        flash[:info] = '学校を選択してください'
        redirect_to school_users_path
      end
    end
  end

  def user_log_out_required
    if current_user
      flash[:info] = 'すでにログインしています。'
      redirect_to root_path
    end
  end
end
