class LessonGroupRequestsController < UserBase
  def index
    @school_building = current_user.main_school_building(current_school)
    @school_grade = school_grade
    @school_year = school_year
    @lesson_groups = @school_building
                        .lesson_groups
                        .for_school_grade(@school_grade)
                        .for_school_year(@school_year)
  end

  def create
  end

  private
  def school_grade
    school_grade = params[:school_grade].to_i
    return current_user.school_grade unless (4..20).include?(school_grade)

    school_grade.to_i
  end

  def school_year
    school_year = params[:school_year].to_i
    return school_year_at unless (2000..9999).include?(school_year)

    school_year.to_i
  end
end
