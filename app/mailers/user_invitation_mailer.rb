class UserInvitationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_invitation_mailer.user_invitation.subject
  #
  def user_invitation(school_user)
    @school_user = school_user
    mail to: school_user.email, subject: "[Marutsuke]#{school.name}への招待メール"
  end
end
