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

  def start_to_end_time
    "#{time_format(start_at) || ''}  −  #{time_format(end_at) || ''}"
  end

  def start_time
    time_format(start_at) || '-'
  end

  def end_time
    time_format(end_at) || '-'
  end

  def start_time_with_y
    time_format_with_y(start_at) || '-'
  end

  def end_time_with_y
    time_format_with_y(end_at) || '-'
  end

  def display_order_select_array(selected: nil)
    return (1..3) if questions.id_not_nil.blank?

    used_display_orders = questions.pluck(:display_order)
    max_display_order = used_display_orders.max
    return_array = (1..max_display_order + 2).to_a - used_display_orders
    if selected
      return_array = (return_array + [selected]).sort
    end
    return_array
  end

  def name_with_lesson_group_and_school_building
    "#{ lesson_group.name }/#{ name } (#{ lesson_group.school_building.name })"
  end

  def question_set_status
    questions.published.size > 0 ? '設定あり' : '未設定'
  end

  def has_checked_qeustion_status
    checking_count > 0 ? '未チェックあり' : ''
  end

  private

  def time_format(time)
    return nil if time == '未設定' || time.nil?

    Time.parse(time).strftime("%-m/%-e(#{I18n.t('date.abbr_day_names')[Time.parse(time).wday]}) %R")
  end

  def time_format_with_y(time)
    return nil if time == '未設定' || time.nil?

    Time.parse(time).strftime("%-y/%-m/%-e(#{I18n.t('date.abbr_day_names')[Time.parse(time).wday]}) %R")
  end
end
