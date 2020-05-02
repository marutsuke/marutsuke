class Teacher::TeachersController < ApplicationController

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      teacher_log_in(@teacher)
      flash[:success] = "ようこそ!#{@teacher.name}さん"
      redirect_to new_teacher_teacher_path
    else
      render 'new'
    end
  end

  private
  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
  end
end
