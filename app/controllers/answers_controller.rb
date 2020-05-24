# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.new(answer_params)
    if @answer.save
      flash[:success] = '課題を提出しました'
      answer_images_save(@answer)
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
end
