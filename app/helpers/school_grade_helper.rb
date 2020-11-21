  module SchoolGradeHelper
  def school_grade_to_s(school_grade)
    SCHOOL_GRADE_HASH[school_grade]
  end
end
