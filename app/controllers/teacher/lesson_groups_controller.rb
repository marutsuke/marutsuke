# frozen_string_literal: true

class Teacher::LessonGroupsController < Teacher::Base
  before_action :set_lesson_groups, only: %i[index new create]
  before_action :set_lesson_group, only: %i[show edit]

  def index; end

  def show; end

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

  def edit; end

  private

  def lesson_group_params
    params.require(:lesson_group).permit(:name, :school_building_id)
  end

  def set_lesson_groups
    @lesson_groups = LessonGroup.for_school_buildings_belonged_to(current_teacher)
  end

  def set_lesson_group
    set_lesson_groups
    @lesson_group = @lesson_groups.find(parmas[:id])
  end
end
