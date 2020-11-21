module LessonGroupRequestHelper

  def next_year_lesson_group_request_link(school_year, school_grade)
    return if school_year > Time.zone.now.year

    link_to '次の年度>>', lesson_group_requests_path(school_grade: school_grade, school_year: school_year + 1)
  end

  def previous_year_lesson_group_request_link(school_year, school_grade)
    return if school_year < 2020

    link_to '<<前の年度', lesson_group_requests_path(school_grade: school_grade, school_year: school_year - 1)
  end

  def next_grade_lesson_group_request_link(school_year, school_grade)
    grade_word = SCHOOL_GRADE_HASH[school_grade + 1]
    return if grade_word.nil?

    link_to "#{ grade_word }>>", lesson_group_requests_path(school_grade: school_grade + 1, school_year: school_year)
  end

  def previous_grade_lesson_group_request_link(school_year, school_grade)
    grade_word = SCHOOL_GRADE_HASH[school_grade - 1]
    return if grade_word.nil?

    link_to "<<#{ grade_word }", lesson_group_requests_path(school_grade: school_grade - 1, school_year: school_year)
  end

end
