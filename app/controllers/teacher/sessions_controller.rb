class Teacher::SessionsController < Teacher::Base
  skip_before_action :teacher_login_required

  def new
  end

  def create
    teacher = Teacher.find_by(email: params[:session][:email].downcase)
    if teacher&.authenticate(params[:session][:password])
      teacher_log_in(teacher)
      flash[:success] = 'ログインに成功しました。'
      params[:session][:remember_me] == '1' ? remember_teacher(teacher) : forget_teacher(teacher)
      redirect_to new_teacher_teacher_path
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています。'
      render :new
    end
  end

  def destroy
    teacher_log_out if current_teacher
    flash[:danger] = 'ログアウトしました。'
    redirect_to teacher_login_path
  end
end
