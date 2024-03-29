# frozen_string_literal: true

class Teacher::TeachersController < Teacher::Base
  before_action :set_teacher, only: %i[show edit update resend_activation_mail destroy restore]

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
      flash[:success] = "#{@teacher.name}先生を作成しました"
      current_teacher_school_building.school_building_teachers.new(teacher_id: @teacher.id, main: true).save
      # flash[:success] = "#{@teacher.name}先生を作成し、アクティベーションメールを送信しました"
      # @teacher.send_activation_mail
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
      redirect_to edit_teacher_teacher_path(@teacher)
    else
      render 'edit'
    end
  end

  def destroy
    if @teacher.update(activated: false) && @teacher.update_attribute(:end_at, Time.zone.now)
      flash[:danger] = "#{@teacher.name}先生のアカウントを無効にしました"
      redirect_to teacher_teacher_path(@teacher)
    end
  end

  def restore
    if @teacher.update(activated: true, end_at: nil)
      flash[:success] = "#{@teacher.name}先生のアカウントを有効にしました"
      redirect_to teacher_teacher_path(@teacher)
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
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation, :start_at_date, :start_at_hour, :start_at_min, :end_at_date, :end_at_hour, :end_at_min, :login_id, :role, :image)
  end

  def teacher_update_params
    params.require(:teacher).permit(:name, :email, :start_at_date, :start_at_hour, :start_at_min, :end_at_date, :end_at_hour, :end_at_min, :login_id, :role, :image)
  end
end
