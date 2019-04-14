class QuestionsController < ApplicationController

  def show
    set_questions
  end

  def new

  end

  def edit

  end

  def create

  end

  def update

  end

  private

  def set_questions
    @question = Question.find(params[:id])
    @small_questions = @question.small_questions
  end

end