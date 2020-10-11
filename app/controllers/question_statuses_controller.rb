class QuestionStatusesController < UserBase
  before_action :set_question_and_status

  def will_do
    if @question.question_status_of(current_user).update(status: :will_do)
      @status = @question.question_status_of(current_user).reload.status
      respond_to do |format|
        format.js
        format.html {
          flash[:success] = 'することになりました。'
          redirect_to @question
        }
      end
    else
      flash[:notice] = '更新エラー'
      redirect_to @lesson
    end
  end

  def maybe_do
    if @question.question_status_of(current_user).update(status: :maybe_do)
      @status = @question.question_status_of(current_user).reload.status
      respond_to do |format|
        format.js
        format.html {
          flash[:success] = 'できたらすることになりました。'
          redirect_to @question
        }
      end
    else
      flash[:notice] = '更新エラー'
      redirect_to @lesson
    end
  end

  def will_not_do
    if @question.question_status_of(current_user).update(status: :will_not_do)
      @status = @question.question_status_of(current_user).reload.status
      respond_to do |format|
        format.js
        format.html {
          flash[:success] = 'しないことになりました。'
          redirect_to @question
        }
      end
    else
      flash[:notice] = '更新エラー'
      redirect_to @lesson
    end
  end

  private
  def set_question_and_status
    @question = Question.find(params[:question_id])
    @lesson = current_school.lessons.find(@question.lesson_id)
  end
end
