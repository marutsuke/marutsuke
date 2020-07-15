class Teacher::CommentDecorator < ApplicationDecorator
  delegate_all

  def updated_at
    super&.strftime('%F-%R')
  end

  def commented_at
    time_format(updated_at)
  end

  def time_format(time)
    Time.parse(time).strftime("%m/%d(#{I18n.t('date.abbr_day_names')[Time.parse(time).wday]}) %R")
  end
end
