# frozen_string_literal: true

class SchoolsController < ApplicationController
  skip_before_action :user_login_required

  def new
    @school = School.new
    @teacher = @school.teachers.build
  end

  def create
    @school = School.new(school_params)
    @teacher = @school.teachers.new(teacher_params[:teacher])
    if @school.save && @teacher.save
      teacher_log_in(@teacher)
      flash[:success] = "ようこそ!#{@teacher.name}さん"
      redirect_to new_teacher_teacher_path
    else
      @school.destroy
      render 'new'
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :login_path)
  end

  def teacher_params
    params.require(:school).permit(teacher: %i[name email password password_confirmation])
  end
end
