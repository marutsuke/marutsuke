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

  # 所属している校舎の生徒のみ講座の絞り込み検索可能
  def lesson_groups_search_select_array
    select_array = []
    school_building_teachers.main_order.each do |school_building_teacher|
      school_building = school_building_teacher.school_building
      select_array << [school_building.name, school_building.lesson_groups.map{ |lesson_group| [lesson_group.name, lesson_group.id] }]
    end
    select_array
  end

  def start_at
    super&.strftime('%F-%R') || '未設定'
  end

  def end_at
    super&.strftime('%F-%R') || '未設定'
  end

end
