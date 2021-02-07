# frozen_string_literal: true

class Teacher::SessionsController < Teacher::Base
  skip_before_action :teacher_login_required
  layout 'layouts/application'
  def new
    @login_path = params[:login_path]
    @school = School.find_by(login_path: @login_path)

    raise ActiveRecord::RecordNotFound unless @school
  end

  def create
    login_path = params[:session][:login_path]
    school = School.find_by(login_path: login_path)

    teacher = school&.teachers&.find_by(login_id: params[:session][:login_id])
    if teacher&.authenticate(params[:session][:password])
      teacher_log_in(teacher)
      flash[:success] = "#{teacher.name}先生、こんにちは!"
      params[:session][:remember_me] == '1' ? remember_teacher(teacher) : forget_teacher(teacher)
      redirect_to teacher_path
    else
      flash[:danger] = 'ログインIDまたはパスワードが間違っています。'
      redirect_to teacher_school_login_path(login_path)
    end
  end

  def destroy
    school = current_teacher_school
    teacher_log_out if current_teacher
    flash[:danger] = 'ログアウトしました。'
    redirect_to teacher_school_login_path(school.login_path)
  end
end
