class QuestionStatusesController < UserBase
  before_action :set_status

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

  def set_status
    @status = current_user.question_statuses.find(params[:id])
  end
end
