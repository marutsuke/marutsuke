class CancelsController < UserBase
  skip_before_action :school_select_required

  def new
    @cancel_reason = current_user.cancel_reasons.new
  end

  def create
    @cancel_reason = current_user.cancel_reasons.new(cancel_reason_params)
    if @cancel_reason.save
      redirect_to edit_cancel_path(@cancel_reason)
    else
      render :new
    end
  end

  def edit
    @cancel_reason = current_user.cancel_reasons.find(params[:id])
  end

  def update
    @cancel_reason = current_user.cancel_reasons.find(params[:id])
    @cancel_reason.update(confirm: true)
    @user = @cancel_reason.user
    user_log_out
    @user.destroy
    flash[:danger] = 'ユーザーを削除しました。ご利用ありがとうございました。'
    redirect_to new_user_path
  end

  private
  def cancel_reason_params
    params.require(:cancel_reason).permit(:reason, :text)
  end
end
