# frozen_string_literal: true

class Teacher::LessonsController < Teacher::Base
  before_action :search_lessons, only: :index
  before_action :set_lesson, only: %i[show edit update]
  def index
    @lessons = @lessons.page(params[:page])
  end

  def show
    @lesson_group = @lesson.lesson_group
    @questions = @lesson.questions
  end

  def new
    @lesson_group = LessonGroup.for_school(current_teacher_school).find(params[:lesson_group_id])
    @lessons = @lesson_group.lessons.where.not(id: nil)
    @lesson = @lesson_group.lessons.new
  end

  def create
    @lesson_group = LessonGroup.for_school(current_teacher_school).find(params[:lesson_group_id])
    @lesson = @lesson_group.lessons.new(lesson_params)
    illegal_check(@lesson)
    @lessons = @lesson_group.lessons.where.not(id: nil)
    if @lesson.save
      flash[:success] = "#{@lesson.name}を作成しました。"
      redirect_to new_teacher_lesson_group_lesson_path(@lesson_group)
    else
      render :new
    end
  end

  def edit
    @lesson_group = @lesson.lesson_group
    @lessons = @lesson_group.lessons
  end

  def update
    @lesson_group = @lesson.lesson_group
    @lessons = @lesson_group.lessons
    if @lesson.update(lesson_params)
      flash[:success] = "#{@lesson.name}を更新しました。"
      redirect_to edit_teacher_lesson_path(@lesson)
    else
      render :edit
    end
  end

  private

  def set_lesson
    @lesson = current_teacher_school.lessons.find(params[:id])
  end

  def search_lessons
    @q = current_teacher_school
          .lessons
          .includes(:teacher, lesson_group: [:school_building])
          .ransack(params[:q])
    @lessons = @q.result(distinct: true)
  end

  def lesson_params
    params.require(:lesson).permit(
      :name, :teacher_id, :start_at_date, :start_at_hour,
      :start_at_min, :end_at_date, :end_at_hour, :end_at_min
    ).merge(school_id: current_teacher_school.id)
  end

  def illegal_check(lesson)
    if teacher_school_check(lesson) && lesson_group_school_check(lesson)
      true
    else
      raise '不正な値です。'
    end
  end

  def teacher_school_check(lesson)
    lesson.teacher.school_id == lesson.school_id
  end

  def lesson_group_school_check(lesson)
    lesson.lesson_group.school_building.school_id == lesson.school_id
  end

end
