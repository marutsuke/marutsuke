class SmallQuestionsController < ApplicationController

  def show
    @small_question = SmallQuestion.find(params[:smallquestionid])
    # count = @small_question.correct_count + 1
    # @small_question.update(correct_count:count)
    @question = @small_question.question
    unless @small_question.answers.where(answer:params[:answer]) == []
        count = @small_question.correct_count + 1
        @small_question.update(correct_count:count) 
        # ,last_correct_day:Time.current.to_date
      respond_to do |format|
        format.html{
        }
        format.json
      end
    end
  end

  def new

  end

  def edit

  end

  def create

  end

  def update

  end


end
