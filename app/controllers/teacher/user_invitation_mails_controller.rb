class Teacher::UserInvitationMailsController < Teacher::Base

  def new
    @school_user = current_school.school_users.new
  end

  def create
    @school_user = current_school.school_users.new(school_user_params)
    if user = User.find_by(@school_user.email)
      @teacher.resend_activation_mail
      flash[:success] = "#{@teacher.name}のアドレス宛にアカウント承認メールを送りました。ご確認ください。"
      redirect_to teacher_path
    else
    end
  end

  def school_user_params
    params.require(:school_user).permit(:email)
  end
end
