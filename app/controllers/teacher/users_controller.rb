# frozen_string_literal: true

class Teacher::UsersController < Teacher::Base
  def new
    @user = User.new
  end

  def create
    @user = current_school.users.new(user_params)
    @user.email = nil if @user.email == ''
    @user.login_id =
      current_school.id.to_s + format('%07d', (User.last&.id || 0) + 1)
    if @user.save
      flash[:success] = "#{@user.name}を作成しました"
      redirect_to new_teacher_user_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :start_at, :end_at, :password, :password_confirmation)
  end
end
