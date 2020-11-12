class SchoolUsersController < UserBase
  skip_before_action :school_select_required
  before_action :school_request_required, only: :index
  def index
    @school_users = current_user.school_users
  end

  def new
    @school_user =  current_user.school_users.new
  end

  def create
    @school_building = SchoolBuilding.find_by(invitation_code: params[:invitation_code]) if params[:invitation_code]

    if @school_building
        # ここで、既に所属ずみの学校でないか、確認。所属済みの場合は、school_userは作成しない。他校受講は、学校側で操作したい。

        school_user = current_user.school_users.create(school_id: @school_building.school.id, school_building_id: @school_building.id)
        school_building_user = current_user.school_building_users.create(school_building_id: @school_building.id, main: true)
        redirect_to new_user_path
    else
      @school_user =  current_user.school_users.new
      flash[:danger] = '招待コートが間違っているようです。'
      render :new
    end
  end

  def select_school
    @school_user = current_user.school_users.find(params[:id])
    if @school_user.activated
      @school = current_user.school_users.find(params[:id]).school
      user_log_in(current_user, @school)
      redirect_to root_path
    else
      @school_users = current_user.school_users
      flash[:danger] = 'まだ、許可されていません。'
      render :index
    end
  end

  private

  def school_request_required
    if current_user.school_users.blank?
      flash[:info] = '招待コードを送って入学しましょう'
      redirect_to new_school_user_path
    end
  end

end
