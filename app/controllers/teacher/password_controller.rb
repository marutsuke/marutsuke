class Teacher::PasswordController < Teacher::Base
  def edit
  end

  def update
    if current_teacher&.authenticate(old_password_param[:old_password])
       if current_teacher.update(password_params)
        flash[:success] = 'パスワードを変更しました'
      else
        flash[:danger] = '新しいパスワードが一致しません'
      end
    else
      flash[:danger] = '元のパスワードが間違っています。'
    end
    redirect_to edit_teacher_password_index_path
  end

  def edit_other
    set_teacher
  end

  def update_other
    set_teacher
    if current_teacher.update(password_params)
      flash[:success] = 'パスワードを変更しました'
      redirect_to edit_other_teacher_password_path(@teacher)
    else
      flash[:danger] = 'パスワードが一致しません'
      redirect_to edit_other_teacher_password_path(@teacher)
    end
  end

  private

  def old_password_param
    params.require(:teacher).permit(:old_password)
  end

  def password_params
    params.require(:teacher).permit(:password, :password_confirmation)
  end

  def set_teacher
    @teacher = current_teacher_school_building.teachers.find(params[:id])
  end
end
