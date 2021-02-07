class Teacher::ImageChangesController < Teacher::Base

  def edit
  end
  def update
    if current_teacher.update(image_params)
      flash[:success] = "更新しました。"
      redirect_to edit_teacher_image_changes_path
    else
      flash[:danger] = '更新に失敗しました'
      render :edit
    end
  end

  private
  def image_params
    params.require(:teacher).permit(:image)
  end
end
