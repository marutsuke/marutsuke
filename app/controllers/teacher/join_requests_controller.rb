class Teacher::JoinRequestsController < Teacher::Base
  before_action :set_join_request, only: %i[accept reject]
  before_action :search_join_requests, only: %i[index]

  def index
    @join_requests = @join_requests.includes(:user).created_desc_order.page(params[:page])
  end

  def accept
    @join_request.accept_user_join
    flash[:success] = "#{ @join_request.user.name }さんの入学を許可しました。"
    redirect_to teacher_join_requests_path
  end

  def reject
    @join_request.update(status: 'rejected')
    flash[:danger] = "#{ @join_request.user.name }さんの入学を拒否しました。"
    redirect_to teacher_join_requests_path
  end

  private

  def set_join_request
    @join_request = current_teacher_school_building.join_requests.find(params[:id])
  end

  def search_join_requests
    @q = current_teacher_school_building.join_requests.ransack(params[:q])
    @join_requests = @q.result(distinct: true)
    # セレクトボックスの初期値設定のため
    if params[:q]
      @status = params[:q][:status_eq]
    end
  end

end
