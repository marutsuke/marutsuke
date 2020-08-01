class UserInvitationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_invitation_mailer.user_invitation.subject
  #
  def user_invitation
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
