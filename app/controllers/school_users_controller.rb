class SchoolUsersController < UserBase
  skip_before_action :school_select_required
  before_action :school_request_required, only: :index
  def index
  end

  def new
  end

  def create
  end

  private

  def school_request_required
    if current_user.school_users.blank?
      flash[:info] = '招待コードを送って入学しましょう'
      redirect_to new_school_user_path
    end
  end

end
