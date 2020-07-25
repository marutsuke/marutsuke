class Teacher::AnswerChecksController < Teacher::Base
  before_action :set_lesson,
                :set_page,
                :set_question_and_answers,
                :active_page_check,
                :set_page_paths

  def checking
    @comment = current_teacher.comments.new
  end

  private

  def set_page
    @page = params[:page]&.to_i || 1
  end

  def set_lesson
    @lesson = current_teacher.lessons.find(params[:lesson_id])
  end

  def set_question_and_answers
    @question_statuses =
      QuestionStatus.order_by_question_order_at(@lesson)
    @question_status = @question_statuses[@page - 1]
    @question = @question_status&.question
    @answers = @question_status&.answers&.new_order
  end

  def active_page_check
    return if @question_status

    redirect_to teacher_lessons_path
  end

  def set_page_paths
    @next_answer_path = checking_teacher_lesson_answer_checks_path(lesson_id: @lesson.id, page: @page + 1)
    @back_answer_path = checking_teacher_lesson_answer_checks_path(lesson_id: @lesson.id, page: @page - 1)

    @next_lessons_ids =
      current_teacher.lessons.to_check.pluck(:id) -
      [@lesson.id]
      if @next_lesson_exist = @next_lessons_ids.present?
        @next_lesson_path =
          checking_teacher_lesson_answer_checks_path(
            lesson_id: @next_lessons_ids.first
          )
      end
    @next_answer_exist = @page < @question_statuses.size
    @back_answer_exist = @page > 1
  end
end
