# frozen_string_literal: true

class Admin::Base < ApplicationController
  include Admin::SessionsHelper
  before_action :admin_login_required
  skip_before_action :user_login_required

  private

  def admin_login_required
    unless current_admin
      flash[:info] = 'ログインしてください'
      redirect_to admin_login_path
    end
  end
end
