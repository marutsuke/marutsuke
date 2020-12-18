module LessonGroupRequestHelper


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
