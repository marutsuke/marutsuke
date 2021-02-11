# frozen_string_literal: true

class LessonGroupDecorator < ApplicationDecorator
  delegate_all

  def target_school_grade
    if max_school_grade.present?
      "#{ SCHOOL_GRADE_HASH[min_school_grade] } ~ #{ SCHOOL_GRADE_HASH[max_school_grade] }"
    else
      SCHOOL_GRADE_HASH[min_school_grade]
    end
  end

  def start_to_end_date
    "#{date_format(start_at)} - #{date_format(end_at) || ''}"
  end


  def free_attend_to_s
    if free_attend
      'すべて許可'
    else
      '要確認'
    end
  end

  def lessons_show_button_html_class(lesson)
    if lesson&.lesson_group&.id == id
      'a-button a-button--primary'
    else
      'a-button a-button--secondary'
    end
  end

  private

  def date_format(date)
    date&.strftime('%Y/%m/%d')
  end


end
