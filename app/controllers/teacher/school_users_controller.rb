class Teacher::SchoolUsersController < Teacher::Base
  before_action :set_school_user

  def edit
  end

  def update
    if @school_user.update(school_user_params)
      flash[:success] = '更新しました'
      redirect_to edit_teacher_school_user_path(@school_user)
    else
      render :edit
    end
  end

  private
  def set_school_user
    @school_user = current_teacher_school.school_users.find(params[:id])
  end

  def school_user_params
    params.require(:school_user).permit(:start_at_date, :start_at_hour, :start_at_min, :end_at_date, :end_at_hour, :end_at_min)
  end
end
