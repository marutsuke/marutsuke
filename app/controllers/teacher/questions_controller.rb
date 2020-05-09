# frozen_string_literal: true

class Teacher::QuestionsController < Teacher::Base
  def create
    @question = current_school
                  &.lessons
                  &.find(question_params[:lesson_id])
                  &.questions
                  &.build(question_params)
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
    params.require(:question).permit(:title, :text, :image, :lesson_id)
  end
end
