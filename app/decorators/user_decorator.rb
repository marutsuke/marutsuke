# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all

  def activated_status
    activated ? '有効' : '無効'
  end

  def email
    super || '未設定'
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

  def change_school_select_array
    schools.map{ |school| [school.name, school.id] }
  end

  private

  def time_format(time)
    return nil if time == '未設定' || time.nil?

    Time.parse(time).strftime("%y/%m/%d(#{I18n.t('date.abbr_day_names')[Time.parse(time).wday]}) %R")
  end
end
