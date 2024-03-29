class LessonGroupRequestsController < UserBase
  def index
    @school_building = current_user.main_school_building(current_school)
    @school_grade = school_grade
    @lesson_groups = @school_building
                        .lesson_groups
                        .for_school_grade(@school_grade)
                        .in_open
  end

  def create
    @lesson_group = LessonGroup.for_school(current_school).for_school_buildings_belonged_to_user(current_user).find(params[:lesson_group_id])
    lesson_group_request= current_user.lesson_group_requests.new(lesson_group_id: @lesson_group.id, school_building_id: @lesson_group.school_building.id)

    if lesson_group_request.save
      flash[:success] = lesson_group_request.attend_free? ? '受講受付完了しました' : '受講リクエストをしました'
      lesson_group_request.accept_user_attend_if_free_attend
      redirect_to lesson_group_requests_path
    else
      flash[:danger] = 'リクエストに失敗しました。'
      redirect_to lesson_group_requests_path
    end
  end

  private
  def school_grade
    school_grade = params[:school_grade].to_i
    return current_user.school_grade unless (4..20).include?(school_grade)

    school_grade.to_i
  end

end
