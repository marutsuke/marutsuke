class Teacher::Base < ApplicationController
  include Teacher::SessionsHelper
  before_action :teacher_login_required

  private

  def teacher_login_required
    unless current_teacher
      flash[:info] = 'ログインしてください'
      redirect_to teacher_login_path
    end
  end
end
