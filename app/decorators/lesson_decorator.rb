# frozen_string_literal: true

class LessonDecorator < Draper::Decorator
  delegate_all
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
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
    "#{time_format(start_at) || ''}  −  #{time_format(end_at) || ''}"
  end

  def complete_rate
    "#{complete_count}/#{User.attendees_at(self).size * questions.size}"
  end

  private

  def time_format(time)
    return nil if time == '未設定' || time.nil?

    Time.parse(time).strftime("%m/%d(#{I18n.t('date.abbr_day_names')[Time.parse(time).wday]}) %R")
  end
end
