# frozen_string_literal: true

class Teacher::LessonGroupsController < Teacher::Base
  def index
    @lesson_groups = LessonGroup.all
  end

  def new
    @lesson_group = LessonGroup.new
  end

  def create
    @lesson_group = LessonGroup.new(lesson_group_params)
    if @lesson_group.save
      flash[:success] = "#{@lesson_group.name}を作成しました。"
      redirect_to new_teacher_lesson_group_path
    else
      render :new
    end
  end

  private

  def lesson_group_params
    params.require(:lesson_group).permit(:name, :school_building_id)
  end
end
