class JoinRequestsController < UserBase
  skip_before_action :school_select_required

  def def new
    @join_requests = current_user.join_equests.new
  end

  def create
    @school_building = SchoolBuilding.find_by(invitation_code: params[:invitation_code]) if params[:invitation_code]

    if @school_building
      @school = @school_building.school
      @join_request = current_user.join_requests.new(school_building_id: @school_building.id, school_id: @school.id)
      if @join_request.save
        flash[:success] = "#{ @school.name }/#{ @school_building.name }へのリクエストを受付ました。"
        redirect_to new_join_request_path
      else
        flash[:danger] = '既にリクエスト済みの学校です。'
        redirect_to new_join_request_path
      end
    end
  end
end
