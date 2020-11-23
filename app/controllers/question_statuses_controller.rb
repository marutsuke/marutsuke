class QuestionStatusesController < UserBase
  before_action :set_question_and_lesson, only: %i[will_do will_not_do maybe_do]
  before_action :set_status, only: %i[change_to_will_do change_to_maybe_do change_to_will_not_do]

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

  def change_to_will_do
    if @status.update(status: :will_do)
      @status = @status.reload
      respond_to do |format|
        format.js
      end
    else
      flash[:notice] = '更新エラー'
    end
  end

  def change_to_maybe_do
    if @status.update(status: :maybe_do)
      @status = @status.reload
      respond_to do |format|
        format.js
      end
    else
      flash[:notice] = '更新エラー'
    end
  end

  def change_to_will_not_do
    if @status.update(status: :will_not_do)
      @status = @status.reload
      respond_to do |format|
        format.js
      end
    else
      flash[:notice] = '更新エラー'
    end
  end

  private
  def set_question_and_lesson
    @question = Question.find(params[:question_id])
    @lesson = current_school.lessons.find(@question.lesson_id)
  end

  def set_status
    @status = current_user.question_statuses.find(params[:id])
  end
end
