# frozen_string_literal: true

class TeacherDecorator < Draper::Decorator
  delegate_all

  def activated_status
    activated ? '有効' : '無効'
  end

  def school_building_select_array
    school_building_teachers
      .main_order
      .map do |school_building_teacher|
        [school_building_teacher.school_building.name,
         school_building_teacher.school_building.id]
      end
  end
end
