# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :user_login_required

  private

  def user_login_required
    unless current_user
      flash[:info] = 'ログインしてください'
      redirect_to login_path
    end
  end
end
