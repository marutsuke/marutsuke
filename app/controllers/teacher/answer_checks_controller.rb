class Teacher::AnswerChecksController < Teacher::Base
  before_action :set_variables, :security_check
  # before_action :set_page,
  #               :set_lesson,
  #               :set_question_and_answers,
  #               :active_page_check,
  #               :set_answer_page_paths,
  #               :set_lesson_page_paths

  def checking
    @comment = current_teacher.comments.new(answer_id: @target_answer.id)
  end

  def check
    @comment = current_teacher.comments.new(comment_params)

    if @comment.save
      flash[:success] = 'コメントしました。'
      @comment.answer.question_status.update(status: 'commented')
      redirect_to checking_teacher_question_status_answer_checks_path(@question_status)
    else
        render :checking
    end
  end

  private

  # TODO: いらないので消すが、コードを一旦残す。
  # def answer_check_params
  #   params.require(:teacher_answer_check_form).permit(:text, :evaluation, :answer_id, :image)
  # end

  def set_variables
    @question_status = QuestionStatus.find(params[:question_status_id])
    @question = @question_status.question
    @lesson = @question.lesson
    @user = @question_status.user
    @answers = @question.answers
    @target_answer = @answers.last
  end

  def security_check
    return if current_teacher_school.id == @lesson.school_id
    raise '不正なリクエストです'
  end

  def set_page
    @page = params[:page]&.to_i || 1
  end

  def set_lesson
    @lesson = current_teacher.lessons.find(params[:lesson_id])
  end

  def set_question_and_answers
    @question_statuses = @lesson.question_statuses_to_check
    @question_status = @question_statuses[@page - 1]
    @question = @question_status&.question
    @answers = @question_status&.answers
  end

  # def active_page_check
  #   return if @question_status
  #   # ロールバーの警告など入れたい
  #   flash[:warning] = '答案が見つかりませんでした'
  #   redirect_to teacher_lessons_path
  # end

  # def set_answer_page_paths
  #   @next_answer_path = checking_teacher_lesson_answer_checks_path(lesson_id: @lesson.id, page: @page + 1)
  #   @back_answer_path = checking_teacher_lesson_answer_checks_path(lesson_id: @lesson.id, page: @page - 1)

  #   @next_answer_exist = @page < @question_statuses.size
  #   @back_answer_exist = @page > 1
  # end

  # def set_lesson_page_paths
  #   @lessons_ids =
  #     current_teacher.lessons.to_check.pluck(:id).uniq
  #   current_lesson_index = @lessons_ids.index(@lesson.id) || 0
  #   if @next_lesson_exist = @lessons_ids[current_lesson_index + 1].present?
  #     @next_lesson_id = @lessons_ids[current_lesson_index + 1]
  #     @next_lesson_path =
  #       checking_teacher_lesson_answer_checks_path(
  #         lesson_id: @next_lesson_id
  #       )
  #   end
  #   if @back_lesson_exist = current_lesson_index > 0
  #     @back_lesson_id = @lessons_ids[current_lesson_index - 1]
  #     back_lesson = Lesson.find(@back_lesson_id)
  #     back_lesson_page = back_lesson.question_statuses_to_check.size
  #     @back_lesson_path =
  #       checking_teacher_lesson_answer_checks_path(
  #         lesson_id: @lessons_ids[current_lesson_index - 1], page: back_lesson_page
  #       )
  #   end
  # end

  def comment_params
    params.require(:comment).permit(:text, :image, :answer_id)
  end
end
