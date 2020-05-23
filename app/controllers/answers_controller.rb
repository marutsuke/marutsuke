# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    answer_params
  end

  private

  def answer_params
    params.require(:answer).permit(:text, :question_id, answer_image: [:image])
  end

  def ansewr_image_params; end
end
