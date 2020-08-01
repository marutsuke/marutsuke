class Teacher::UserInvitationMailsController < Teacher::Base

  def new
    @school_user = current_school.school_users.new
  end

  def create
    @school_user = current_school.school_users.new(school_user_params)
    if @school_user.save
      if user = User.find_by(email: @school_user.email)
        @school_user.update(user_id: user.id)
        @school_user.send_user_invitation
        flash[:success] = "#{@school_user.email}宛に招待メールを送りました。"
        redirect_to teacher_users_path
      else
        flash[:success] = "#{@school_user.email}宛に新規登録案内 & 招待メールを送りました。"
        @school_user.send_new_user_invitation
        redirect_to teacher_users_path
      end
    else
      render :new
    end
  end

  def school_user_params
    params.require(:school_user).permit(:email)
  end
end
