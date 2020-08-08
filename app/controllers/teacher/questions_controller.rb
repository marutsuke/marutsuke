# frozen_string_literal: true

class Teacher::QuestionsController < Teacher::Base
  def new
    @lesson = current_teacher_school.lessons.find(params[:lesson_id])
    @question = @lesson.questions.build
    @questions = @lesson.questions
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
