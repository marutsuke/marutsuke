# frozen_string_literal: true

class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @lesson = current_school&.lessons&.find(@question.lesson_id)
    @answer = current_user.answers.new
  end
end
