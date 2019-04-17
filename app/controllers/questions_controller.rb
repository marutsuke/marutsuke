class QuestionsController < ApplicationController

  def show
    set_questions
  end

  def new
    set_section
  end

  def edit

  end

  def create
    new_question_create
    redirect_to action: :new
  end

  def update

  end

  private

    def set_questions
      @question = Question.find(params[:id])
      @small_questions = @question.small_questions
    end

    def new_question_create
      if (params[:text] != "" && params["small_text-1".to_sym]) != ""
        question = Question.create(text:params[:text],section_id:params[:section_id])
        small_num = 1
        while params["small_text-#{small_num}".to_sym] do
          if params["small_text-#{small_num}".to_sym] !=  ""
          SmallQuestion.create(text:params["small_text-#{small_num}".to_sym], question_id:question.id)
          small_num += 1
          end
        end
      end
    end

    def set_section
      @section = Section.find(params[:section_id])
      @questions = @section.questions
    end

end