class SmallQuestionsController < ApplicationController

  protect_from_forgery :except => [:destroy]

  def index
    @question=Question.includes({small_questions: [:answers]}).find(params[:question_id])
  end

  def show
    @small_question = SmallQuestion.find(params[:smallquestionid])
    @question = @small_question.question
    unless @small_question.answers.where(answer:params[:answer]) == []
      count = @small_question.correct_count + 1
      @small_question.update(correct_count:count)
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
