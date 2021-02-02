# frozen_string_literal: true

class Teacher::TeachersController < Teacher::Base
  before_action :set_teacher, only: %i[show edit update resend_activation_mail]

  def index
    @teachers = current_teacher_school_building.teachers.page(params[:page])
  end

  def show; end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = current_teacher_school.teachers.new(teacher_params)
    if @teacher.save
      flash[:success] = "#{@teacher.name}先生を作成し、アクティベーションメールを送信しました"
      @teacher.send_activation_mail
      redirect_to new_teacher_teacher_path
    else
      render 'new'
    end
  end

  def edit
    @teacher = current_teacher_school.teachers.find(params[:id])
  end

  def update
    if @teacher.update(teacher_update_params)
      flash[:success] = "#{@teacher.name}先生の情報を更新しました。"
      redirect_to teacher_teachers_path
    else
      render 'edit'
    end
  end

  def resend_activation_mail
    @teacher.resend_activation_mail
    flash[:success] = "#{@teacher.name}のアドレス宛にアカウント承認メールを送りました。ご確認ください。"
    redirect_to teacher_teachers_path
  end

  private

  def set_teacher
    @teacher = current_teacher_school.teachers.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
  end

  def teacher_update_params
    params.require(:teacher).permit(:name, :email)
  end
end
