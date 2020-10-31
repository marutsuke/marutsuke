# frozen_string_literal: true

class Teacher::LessonGroupsController < Teacher::Base
  before_action :set_lesson_groups, only: %i[index new create]
  before_action :set_lesson_group, only: %i[show edit update destroy]

  def index; end

  def show
    @lessons = @lesson_group.lessons.page(params[:page])
    @users = @lesson_group.users.page(params[:page])
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

  def edit
    @lesson = @lesson_group.lessons.new
    @lessons = @lesson_group.lessons
  end

  def update
    if @lesson_group.update(lesson_group_params)
      flash[:success] = "#{@lesson_group.name}を更新しました。"
      redirect_to edit_teacher_lesson_group_path(@lesson_group)
    else
      render :edit
    end
  end

  def destroy
    @leeson_group.destory
    redirect_to teacher_lesson_groups_path
  end

  private

  def lesson_group_params
    params.require(:lesson_group).permit(:name, :school_building_id, :school_year, :min_school_grade, :max_school_grade)
  end

  def set_lesson_groups
    @lesson_groups = LessonGroup.for_school(current_teacher_school)
  end

  def set_lesson_group
    set_lesson_groups
    @lesson_group = @lesson_groups.find(params[:id])
  end
end
