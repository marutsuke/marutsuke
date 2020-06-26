# frozen_string_literal: true

class Teacher::TeachersController < Teacher::Base
  def index
    @teachers = current_school.teachers
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = current_school.teachers.new(teacher_params)
    if @teacher.save
      flash[:success] = "#{@teacher.name}先生を作成しました"
      redirect_to new_teacher_teacher_path
    else
      render 'new'
    end
  end

  def edit
    @teacher = current_school.teachers.find(params[:id])
  end

  def update
    @teacher = current_school.teachers.find(params[:id])
    if @teacher.update(teacher_update_params)
      flash[:success] = "#{@teacher.name}先生の情報を更新しました。"
      redirect_to teacher_teachers_path
    else
      render 'edit'
    end
  end

  def resend_activation_mail
    @teacher = current_school.teachers.find(params[:id])
    @teacher.resend_activation_mail
    flash[:success] = "#{@teacher.name}のアドレス宛にアカウント承認メールを送りました。ご確認ください。"
    redirect_to teacher_teachers_path
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
  end

  def teacher_update_params
    params.require(:teacher).permit(:name, :email)
  end
end
