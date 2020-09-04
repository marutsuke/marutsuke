# frozen_string_literal: true

class UsersController < UserBase
  def mypage; end

  def change_school
    school = current_user.schools.find(params[:school_id])
    user_log_in(current_user, school)
    flash[:success] = "#{school.name}に切り替えました"
    redirect_to root_path
  end

  def edit

  end
end
