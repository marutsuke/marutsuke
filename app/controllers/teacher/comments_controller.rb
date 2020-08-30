# frozen_string_literal: true

class Teacher::CommentsController < Teacher::Base

  def index
    @comments = current_teacher.comments
  end

  def create
    @comment = current_teacher.comments.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントしました。'
      redirect_to teacher_question_path(@comment.answer.question)
    else
      flash[:danger] = 'コメントに失敗しました。'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :image, :answer_id)
  end
end
