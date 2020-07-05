# frozen_string_literal: true

class AnswersController < ApplicationController

  def new
    @question = Question.find(params[:question_id])
    @lesson = current_school&.lessons&.find(@question.lesson_id)
    @answer = current_user.answers.new
  end

  def create
    @answer = current_user.answers.new(answer_params)
    if @answer.save
      flash[:success] = '課題を提出しました'
      answer_images_save(@answer)
      question_status_update(@answer.question)
      redirect_to question_path(@answer.question)
    else
      flash[:danger] = '解答の保存に失敗しました。'
      render template: 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:text, :question_id)
  end

  def answer_images
    if params.require(:answer)[:answer_image].present?
      params.require(:answer)&.require(:answer_image)&.permit({ image: [] })[:image]
    end
  end

  def answer_images_save(answer)
    answer_images&.each do |image|
      answer_image = answer.answer_images.new(image: image)
      if answer_image.save
        flash[:success] = '課題と画像を提出しました'
      else
        flash[:danger] = '画像の保存に失敗しました。形式やサイズが間違っていないか確かめてください。'
      end
    end
  end

  def question_status_update(question)
    if question_status = current_user.question_statuses.find_by(question_id: question.id)
      question_status.update(status: :checking)
    else
      current_user
        .question_statuses
        .new(question_id: question.id, status: :checking).save
    end
  end
end
