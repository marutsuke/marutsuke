class UserInvitationMailer < ApplicationMailer

  def user_invitation(school_user)
    @school_user = school_user
    mail to: school_user.email, subject: "[Marutsuke]#{school.name}への招待メール"
  end

  def new_user_invitation(school_user)
    @school_user = school_user
    mail to: school_user.email, subject: "[Marutsuke]新規登録のご案内と#{school.name}への招待メール"
  end
end
