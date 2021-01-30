class Teacher::LessonGroupRequestsController < Teacher::Base
  before_action :set_lesson_group_request, only: %i[accept reject]
  before_action :search_join_requests, only: %i[index]

  def index
    @lesson_group_requests = @lesson_group_requests.created_desc_order.page(params[:page])
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

  def search_join_requests
    @q = current_teacher_school_building.lesson_group_requests.ransack(params[:q])
    @lesson_group_requests = @q.result(distinct: true)
    # セレクトボックスの初期値設定のため
    if params[:q]
      @status = params[:q][:status_eq]
    end
  end

  def set_lesson_group_request
    @lesson_group_request = current_teacher_school_building.lesson_group_requests.find(params[:id])
  end
end
