# frozen_string_literal: true

class Teacher::Base < ApplicationController
  include Teacher::SessionsHelper
  before_action :teacher_login_required
  before_action :teacher_must_belong_to_school_building
  before_action :school_must_have_school_building
  skip_before_action :user_login_required

  layout 'teacher/layouts/teacher_layout'

  private

  def teacher_login_required
    unless current_teacher
      store_location
      flash[:info] = 'ログインしてください'
      redirect_to teacher_login_path
    end
  end

  def school_must_have_school_building
    return unless current_teacher
    return unless current_school.school_buildings.empty?

    flash[:info] = '校舎を登録してください。'
    redirect_to new_teacher_school_building_path
  end

  def teacher_must_belong_to_school_building
    return unless current_teacher
    return if current_school.school_buildings.empty?
    return unless current_teacher.school_buildings.empty?

    flash[:info] = '所属校を登録してください。'
    redirect_to new_teacher_teacher_school_building_teacher_path(current_teacher)
  end
end
