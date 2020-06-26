# frozen_string_literal: true

class Teacher::TeachersController < Teacher::Base
  def index
    @teachers = current_school.teachers
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = current_school.teachers.new(teacher_params)
    if @teacher.save
      flash[:success] = "#{@teacher.name}先生を作成しました"
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
