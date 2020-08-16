# frozen_string_literal: true

class SchoolsController < UserBase
  skip_before_action :user_login_required

  def new
    @school = School.new
    @teacher = @school.teachers.build
  end

  def create
    @school = School.new(school_params)
    @teacher = @school.teachers.new(teacher_params[:teacher])
    if @school.save && @teacher.save
      @teacher.send_activation_mail
      flash[:success] = "#{@teacher.email}宛にアカウント承認メールを送りました。ご確認ください。"
      redirect_to new_school_path
    else
      @school.destroy
      render 'new'
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :login_path)
  end

  def teacher_params
    params.require(:school).permit(teacher: %i[name email password password_confirmation])
  end
end
