# frozen_string_literal: true

class Teacher::UsersController < Teacher::Base
  def index
    @users = current_school.users
  end

  def new
    @user = User.new
  end

  def create
    @user = current_school.users.new(user_params)
    @user.email = nil if @user.email == ''
    if @user.save
      flash[:success] = "#{@user.name}を作成しました"
      redirect_to new_teacher_user_path
    else
      render :new
    end
  end

  def show
    @user = current_school.users.find(params[:id]).decorate
  end

  def edit
    @user = current_school.users.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :start_at_date,
      :start_at_hour,
      :start_at_min,
      :end_at_date,
      :end_at_hour,
      :end_at_min,
      :password,
      :password_confirmation
    )
  end
end
