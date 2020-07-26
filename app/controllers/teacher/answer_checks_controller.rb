class Teacher::AnswerChecksController < Teacher::Base
  before_action :set_page,
                :set_lesson,
                :set_question_and_answers,
                :active_page_check,
                :set_answer_page_paths,
                :set_lesson_page_paths

  def checking
    @comment = current_teacher.comments.new
  end

  def check

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

  def set_answer_page_paths
    @next_answer_path = checking_teacher_lesson_answer_checks_path(lesson_id: @lesson.id, page: @page + 1)
    @back_answer_path = checking_teacher_lesson_answer_checks_path(lesson_id: @lesson.id, page: @page - 1)

    @next_answer_exist = @page < @question_statuses.size
    @back_answer_exist = @page > 1
  end

  def set_lesson_page_paths
    @lessons_ids =
      current_teacher.lessons.to_check.pluck(:id).uniq
    current_lesson_index = @lessons_ids.index(@lesson.id)
    if @next_lesson_exist = @lessons_ids[current_lesson_index + 1].present?
      @next_lesson_path =
        checking_teacher_lesson_answer_checks_path(
          lesson_id: @lessons_ids[current_lesson_index + 1]
        )
    end
    if @back_lesson_exist = current_lesson_index > 0
      back_lesson = Lesson.find(@lessons_ids[current_lesson_index - 1])
      back_lesson_page = QuestionStatus.order_by_question_order_at(back_lesson).size
      @back_lesson_path =
        checking_teacher_lesson_answer_checks_path(
          lesson_id: @lessons_ids[current_lesson_index - 1], page: back_lesson_page
        )
    end
  end
end
