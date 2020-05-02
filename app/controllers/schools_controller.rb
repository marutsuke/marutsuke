class SchoolsController < ApplicationController
  def new
    @school = School.new
    @teacher = @school.teachers.build
  end

  def create
    @school = School.new(school_params)
    @teacher = @school.teachers.new(teacher_params[:teacher])
    if @school.save && @teacher.save
      # teacher_log_in(@teacher)
      flash[:success] = "ようこそ!#{@teacher.name}さん"
      redirect_to new_teacher_teacher_path
    else
      @school.destroy
      render 'new'
    end
  end

  private

  def school_params
    params.require(:school).permit(:name)
  end

  def teacher_params
    params.require(:school).permit(teacher: [:name, :email, :password, :password_confirmation, :school_id])
  end
end
