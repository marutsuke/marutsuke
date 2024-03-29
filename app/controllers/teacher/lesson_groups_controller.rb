# frozen_string_literal: true

class Teacher::LessonGroupsController < Teacher::Base
  before_action :search_lesson_groups, only: %i[index]
  before_action :set_lesson_group, only: %i[show edit update destroy]

  def index
    @lesson_groups = @lesson_groups.page(params[:page])
  end

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
    if @lesson_group.lessons.exists?
      flash[:danger] = "授業があるので削除できません"
      redirect_to edit_teacher_lesson_group_path(@lesson_group)
    else
      @lesson_group.destroy
      flash[:danger] = "#{@lesson_group.name}を削除しました。"
      redirect_to teacher_lesson_groups_path
    end
  end

  private

  def lesson_group_params
    params.require(:lesson_group).permit(:name, :school_building_id, :school_year, :min_school_grade, :max_school_grade, :free_attend, :start_at, :end_at)
  end

  def set_lesson_groups
    @lesson_groups = current_teacher_school_building.lesson_groups.min_school_grade_order.page(params[:page])
  end

  def set_lesson_group
    set_lesson_groups
    @lesson_group = @lesson_groups.find(params[:id])
  end

  def search_lesson_groups
    @q = current_teacher_school_building.lesson_groups.ransack(params[:q])
    @lesson_groups = @q.result(distinct: true)
    # セレクトボックスの初期値設定のため
    if params[:q]
      @school_year = params[:q][:school_year_eq]
      @lesson_group_name = params[:q][:name_cont]
      @min_school_grade = params[:q][:min_school_grade_eq]
      @max_school_grade = params[:q][:max_school_grade_eq]
    end
  end
end
