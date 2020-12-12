  module SchoolGradeHelper
  def school_grade_to_s(school_grade)
    SCHOOL_GRADE_HASH[school_grade]
  end

  def school_grade_select_array
    SCHOOL_GRADE_HASH.map{ |k, v| [v, k]}
  end
end
