class Teacher::PasswordController < Teacher::Base
  def edit
  end

  def update
    if current_teacher&.authenticate(old_password_param[:old_password])
      current_teacher.update(password_params)
      flash[:success] = 'パスワードを変更しました'
      redirect_to edit_teacher_password_index_path
    else
      flash[:danger] = '元のパスワードが間違っています。'
      redirect_to edit_teacher_password_index_path
    end
  end

  private

  def old_password_param
    params.require(:teacher).permit(:old_password)
  end

  def password_params
    params.require(:teacher).permit(:password, :password_confirmation)
  end
end
