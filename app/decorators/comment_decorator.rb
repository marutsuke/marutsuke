class CommentDecorator < Draper::Decorator
  delegate_all

  def updated_at
    super&.strftime('%F-%R')
  end

  def commented_at
    created_at.strftime("%-y/%-m/%e %R")
  end

  def created_at
    super.strftime("%-y/%-m/%e %R")
  end

  private

  def time_format(time)
    Time.parse(time).strftime("%-y/%-m/%e(#{I18n.t('date.abbr_day_names')[Time.parse(time).wday]}) %R")
  end
end
