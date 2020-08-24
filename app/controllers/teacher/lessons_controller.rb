# frozen_string_literal: true

class Teacher::LessonsController < Teacher::Base
  before_action :search_lessons, only: :index
  def index
    @lessons = @lessons.page(params[:page])
  end

  def show
    @lesson = current_teacher_school.lessons.find(params[:id])
    @question = @lesson.questions.build
    @questions = @lesson.questions
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = current_teacher_school.lessons.new(lesson_params)
    @lesson_group = @lesson.lesson_group
    if @lesson.save
      flash[:success] = "#{@lesson.name}を作成しました。"
      redirect_to edit_teacher_lesson_group_path(@lesson_group)
    else
      render 'teacher/lesson_groups/edit'
    end
  end

  private

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
      :start_at_min, :end_at_date, :end_at_hour, :end_at_min,
      :lesson_group_id
    )
  end
end
