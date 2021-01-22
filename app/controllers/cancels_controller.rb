class CancelsController < UserBase
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
  end

  private
  def cancel_reason_params
    params.require(:cancel_reason).permit(:reason, :text)
  end
end
