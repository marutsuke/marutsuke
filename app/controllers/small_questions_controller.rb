class SmallQuestionsController < ApplicationController

  protect_from_forgery :except => [:destroy]

  def index
    @question=Question.includes({small_questions: [:answers]}).find(params[:question_id])
  end

  def show

  end

  def new

  end

  def edit
  end

  def create

  end

  def update

  end

  def destroy
    @small_question = SmallQuestion.find(params[:small_question_id])
    @small_question.destroy

    respond_to do |format|
      format.html{
      }
      format.json
    end

    # redirect_to controller: 'books',action: 'index'
  end
  #
  # end

end
