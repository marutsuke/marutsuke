# frozen_string_literal: true

class Teacher::CommentsController < Teacher::Base
  include Rails.application.routes.url_helpers
  before_action :set_variables, :security_check, only: %i[new create]

  def index
    @comments = current_teacher.comments
  end

  def new
    @comment = current_teacher.comments.new(answer_id: @target_answer.id)
  end

  def create
    @comment = current_teacher.comments.new(comment_params)
    commnet_security_check
    if @comment.save
      flash[:success] = 'コメントしました。'
      send_notification_to_user(@comment.answer.user, @comment)
      @comment.answer.question_status.update(status: 'commented')
      redirect_to new_teacher_question_status_comment_path(@question_status)
    else
      flash[:danger] = 'コメントに失敗しました。'
        render :new
    end
  end

  private

  def set_variables
    @question_status = QuestionStatus.find(params[:question_status_id])
    @question = @question_status.question
    @lesson = @question.lesson
    @answers = @question_status.answers
    @target_answer = @answers.last
  end

  def security_check
    return if current_teacher_school.id == @lesson.school_id

    raise '不正なリクエストです'
  end

  def commnet_security_check
    return if @answers.pluck(:id).include?(@comment.answer_id)

    raise '不正なリクエストです'
  end

  def comment_params
    params.require(:comment).permit(:text, :image, :answer_id)
  end

  def send_notification_to_user(user, comment)
    message = "先生からのコメントがあります。\n\n#{comment.text}\n\nリンク:#{ question_url(comment.answer.question) }"
    user.send_notification(message)
  end
end
