module SchoolGradeHelper
  def school_grade_i18n(school_grade)
    SCHOOL_GRADE_HASH[school_grade]
  end
end
