# frozen_string_literal: true

class Teacher::QuestionsController < Teacher::Base
  def new
    @lesson = current_teacher_school.lessons.find(params[:lesson_id])
    @lesson_group = @lesson.lesson_group
    @question = @lesson.questions.build
    @questions = @lesson.questions.display_order
  end

  def show
    @question = Question.find(params[:id])
    @lesson = current_teacher_school&.lessons.find_by(id: @question.lesson_id)

    render 'errors/not_found' unless @lesson
  end

  def create
    @question = current_teacher_school
                  &.lessons
                  &.find(question_params[:lesson_id])
                  &.questions.new(question_params)
    if @question.save
      flash[:success] = "#{@question.title}を作成しました。"
      redirect_to new_teacher_lesson_question_path(@question.lesson)
    else
      @lesson = @question.lesson
      @questions = @lesson.questions
      render template: 'teacher/lessons/show'
    end
  end

  private

  def question_params
    params.require(:question).permit(:text, :image, :lesson_id, :display_order, :publish)
  end
end
