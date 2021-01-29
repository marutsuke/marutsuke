# frozen_string_literal: true

class JoinRequestDecorator < Draper::Decorator
  delegate_all

  def created_at
    super&.strftime('%F-%R')
  end

  def updated_at
    super&.strftime('%F-%R')
  end

  def start_at
    super&.strftime('%F-%R') || '未設定'
  end

  def end_at
    super&.strftime('%F-%R') || '未設定'
  end

  def start_at_for_user
    time_format(start_at) || '未設定'
  end

  def end_at_for_user
    time_format(end_at) || '未設定'
  end

  def start_to_end_time
    "#{time_format(start_at) || ''} ~ #{time_format(end_at) || ''}"
  end

  def change_school_select_array(excepts = [])
    (schools - excepts).map{ |school| [school.name, school.id] }
  end

  def school_grade_to_s
    SCHOOL_GRADE_HASH[school_grade]
  end

  private

  def time_format(time)
    return nil if time == '未設定' || time.nil?

    Time.parse(time).strftime("%y/%m/%d(#{I18n.t('date.abbr_day_names')[Time.parse(time).wday]}) %R")
  end
end
