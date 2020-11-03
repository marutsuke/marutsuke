# frozen_string_literal: true

class Teacher::QuestionsController < Teacher::Base
  before_action :set_question_and_lesson, only: %i[show publish edit update destroy]

  def new
    @lesson = current_teacher_school.lessons.find(params[:lesson_id])
    @lesson_group = @lesson.lesson_group
    @question = @lesson.questions.build
    @questions = @lesson.questions.display_order
  end

  # TODO: 2020/11/03 使わないアクションなので消す。
  # def show
  # end

  def create
    @lesson = current_teacher_school
              &.lessons
              &.find(question_params[:lesson_id])
    @lesson_group = @lesson.lesson_group
    @question = @lesson&.questions.new(question_params)
    if @question.save
      flash[:success] = "課題#{@question.display_order}を作成しました。"
      redirect_to new_teacher_lesson_question_path(@lesson)
    else
      @lesson = @question.lesson
      @questions = @lesson.questions.id_not_nil
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:success] = "課題#{@question.display_order}を更新しました。"
      redirect_to edit_teacher_question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = "課題#{@question.display_order}を削除しました。"
    redirect_to new_teacher_lesson_question_path(@lesson)
  end

  def publish
    if @question.update(publish: true)
      respond_to { |format| format.js } # publish.js.coffee
    else
      flash[:success] = "#{@question.title}の公開に失敗しました。"
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:text, :image, :lesson_id, :display_order, :publish)
  end

  def set_question_and_lesson
    @question = Question.find(params[:id])
    @lesson = current_teacher_school&.lessons.find_by(id: @question.lesson_id)
    @lesson_group = @lesson.lesson_group

    render 'errors/not_found' unless @lesson
  end
end
