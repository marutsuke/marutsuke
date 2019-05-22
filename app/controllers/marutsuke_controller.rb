class MarutsukeController < ApplicationController
  def create
    @small_question = SmallQuestion.find(params[:smallquestionid])
    @question = @small_question.question
    if @small_question.answers.find_by(answer: params[:answer])
      current_user.small_questions << @small_question
      respond_to do |format|
        format.json
      end
    end
  end

  def show

  end

end
