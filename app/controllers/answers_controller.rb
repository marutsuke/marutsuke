class AnswersController < ApplicationController

  protect_from_forgery :except => [:destroy,:create]

  def show
  end

  def create
    new_answer_create
    respond_to do |format|
       format.html{
        redirect_to controller: 'questions', action: 'new', section_id: @small_question.question.section.id
       }
       format.json
    end
  end

  def update

  end

  private

    def new_answer_create
      @small_question = SmallQuestion.find(params[:small_question_id])
      @answer=Answer.create(answer:params[:answer], small_question_id: params[:small_question_id])
    end
end

#解答、複数登録の方法 num = 1
# 4.times do
#   answer = "answer-#{num}".to_sym
#   if params[answer] != ""
#     Answer.create(answer:params[answer], small_question_id: params[:small_question_id])
#   end
#   num += 1
# end
