# frozen_string_literal: true

class Teacher::QuestionsController < Teacher::Base
  def show
    @question = Question.find(params[:id])
    @lesson = current_school&.lessons.find(@question.lesson_id)
  end

  def create
    @question = current_school
                  &.lessons
                  &.find(question_params[:lesson_id])
                  &.questions.new(question_params)
    if @question.save
      flash[:success] = "#{@question.title}を作成しました。"
      redirect_to teacher_lesson_path(@question.lesson)
    else
      @lesson = @question.lesson
      @questions = @lesson.questions
      render template: 'teacher/lessons/show'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :text, :image, :lesson_id, :display_order)
  end
end
