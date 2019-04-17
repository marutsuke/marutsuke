class SmallQuestionsController < ApplicationController

  def show
    set_small_question

  end

  def new

  end

  def edit

  end

  def create

  end

  def update

  end

  def set_small_question
    @small_question = SmallQuestion.find(params[:smallquestionid])
  end

end
