class Teacher::MypageController < Teacher::Base
  def index
  end

  def edit
  end

  def update
    if current_teacher.update(teacher_update_params)
      flash[:success] = '基本情報を更新しました'
      redirect_to edit_teacher_mypage_index_path
    else
      render :edit
    end
  end

  private

  def teacher_update_params
    params.require(:teacher).permit(:name, :email, :login_id)
  end

end
