class Teacher::JoinRequestsController < Teacher::Base
  before_action :set_join_request, only: %i[accept reject]
  def index
    @join_requests = current_teacher_school_building.join_requests.requested
    @checked_join_requests = current_teacher_school_building.join_requests.checked_recently
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

end
