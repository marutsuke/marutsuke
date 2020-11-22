class Teacher::LessonGroupRequestsController < Teacher::Base
  before_action :set_lesson_group_request, only: %i[accept reject]

  def index
    @lesson_group_requests = current_teacher_school_building.lesson_group_requests.requested
    @checked_lesson_group_requests = current_teacher_school_building.lesson_group_requests.checked_recently_lgr
  end

  def accept
    @lesson_group_request.accept_user_attend
    flash[:success] = "受講を許可しました。"
    redirect_to teacher_lesson_group_requests_path
  end

  def reject
    @lesson_group_request.update(status: 'rejected')
    flash[:danger] = 'リクエストを拒否しました。'
    redirect_to teacher_lesson_group_requests_path
  end

  private

  def set_lesson_group_request
    @lesson_group_request = current_teacher_school_building.lesson_group_requests.find(params[:id])
  end
end
