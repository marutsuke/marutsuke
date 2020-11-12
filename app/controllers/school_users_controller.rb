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
        if @school_building.invite_user(current_user)
          flash[:success] = "#{ @school_building.school.name }/#{ @school_building.name }に入学リクエストを送りました。"
          redirect_to new_school_user_path
        else
          flash[:danger] = '既に所属している学校です。'
          redirect_to new_school_user_path
        end
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
      flash[:success] = " #{@school.name} に切り替えました。"
      user_log_in(current_user, @school)
      redirect_to school_users_path
    else
      @school_users = current_user.school_users
      flash[:danger] = '許可されていません。'
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
