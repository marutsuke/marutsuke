class MarutsukeController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    @small_question = SmallQuestion.find(params[:smallquestionid])
    @question = @small_question.question
    @user_answer = params[:answer]
    @answers = @small_question.answers.map{|answer| answer.answer}
    if @small_question.answers.find_by(answer: params[:answer])
      current_user.small_questions.destroy(@small_question)
      current_user.small_questions << @small_question
      respond_to do |format|
        format.json
      end
    end
  end

  def show
  end

end
