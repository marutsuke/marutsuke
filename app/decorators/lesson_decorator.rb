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
    Time.parse(start_at).strftime("%y/%m/%d(#{I18n.t('date.abbr_day_names')[Time.parse(start_at).wday]}) %R") || '未設定'
  end

  def end_at_for_user
    Time.parse(end_at).strftime("%y/%m/%d(#{I18n.t('date.abbr_day_names')[Time.parse(end_at).wday]}) %R") || '未設定'
  end
end
