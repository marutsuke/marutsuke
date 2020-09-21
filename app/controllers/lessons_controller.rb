# frozen_string_literal: true

class LessonsController < UserBase
  before_action :set_lesson_and_questions, only: [:show]
  def index
    lesson_group_ids = current_user.lesson_groups.for_school(current_school).pluck(:id)
    @new_lessons = current_school
      .lessons
      .where(lesson_group_id: lesson_group_ids)
      .includes(:teacher)
      .has_published_question
  end

  def show
  end

  private

  def set_lesson_and_questions
    @lesson = current_school&.lessons&.find(params[:id])
    @questions = @lesson.questions.published

    if @questions.blank?
      flash[:danger] = '課題のない授業です'
      redirect_to lessons_path
    end
  end

end
