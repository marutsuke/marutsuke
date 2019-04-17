class AnswersController < ApplicationController
  def show

  end

  def create
    new_answer_create

    redirect_to controller: 'questions', action: 'new', section_id: @small_question.question.section.id
  end

  def update

  end

  private

    def new_answer_create
      @small_question = SmallQuestion.find(params[:small_question_id])
      num = 1
      4.times do
        answer = "answer-#{num}".to_sym
        if params[answer] != ""
          Answer.create(answer:params[answer], small_question_id: params[:small_question_id])
        end
        num += 1
      end
    end
end

