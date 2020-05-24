# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.new(answer_params)
    if @answer.save
      answer_images.each do |image|
        @answer_image = @answer.answer_images.new(image: image)
        if @answer_image.save
          flash[:success] = '課題を提出しました'
        else
          flash[:danger] = 'imageの保存に失敗しました。'
        end
      end
      redirect_to question_path(@answer.question)
    else
      flash[:danger] = 'そもそもanswerの保存に失敗しました。'
      render template: 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:text, :question_id)
  end

  def answer_images
    params.require(:answer).require(:answer_image).permit({ image: [] })[:image]
  end
end
