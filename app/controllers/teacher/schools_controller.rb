# frozen_string_literal: true

class Teacher::SchoolsController < Teacher::Base
  def edit; end

  def update
    if current_school.update(school_params)
      flash[:success] = "#{current_school.name}の情報を更新しました"
      redirect_to edit_teacher_school_path(current_school)
    else
      render :edit
    end
  end

  private

  def school_params
    params.require(:school).permit(:login_path, :name)
  end
end
