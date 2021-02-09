# frozen_string_literal: true

class Teacher::Base < ApplicationController
  include Teacher::SessionsHelper
  before_action :teacher_login_required
  before_action :teacher_must_belong_to_school_building
  before_action :school_must_have_school_building

  layout 'teacher/layouts/teacher_layout'

  private

  def teacher_login_required
    unless current_teacher
      teacher_store_location
      flash[:info] = 'ログインしてください'
      teacher_school_login_path = cookies.signed[:teacher_school_login_path]
      if teacher_school_login_path
        redirect_to teacher_school_login_path(teacher_school_login_path)
      else
        redirect_to teacher_school_login_path('unknown')
      end
    end
  end

  def school_must_have_school_building
    return unless current_teacher
    return unless current_teacher_school.school_buildings.empty?

    flash[:info] = '校舎を登録してください。'
    redirect_to new_teacher_school_building_path
  end

  def teacher_must_belong_to_school_building
    return unless current_teacher
    return if current_teacher_school.school_buildings.empty?
    return unless current_teacher.school_buildings.empty?

    flash[:info] = '所属校を登録してください。'
    redirect_to new_teacher_teacher_school_building_teacher_path(current_teacher)
  end

  def regular_teacher_authority_required
    return if current_teacher&.regular_teacher_authority? || current_teacher.nil?

    flash[:danger] = '権限がありません'
    redirect_to teacher_path
  end

  def school_building_owner_authority_required
    return if current_teacher&.school_building_owner_authority? || current_teacher.nil?

    flash[:danger] = '権限がありません'
    redirect_to teacher_path
  end

  def school_owner_authority_required
    return if current_teacher&.school_owner_authority? || current_teacher.nil?

    flash[:danger]  = '権限がありません'
    redirect_to teacher_path
  end
end
