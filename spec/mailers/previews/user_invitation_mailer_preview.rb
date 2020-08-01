# Preview all emails at http://localhost:3000/rails/mailers/user_invitation_mailer
class UserInvitationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_invitation_mailer/user_invitation
  def user_invitation
    UserInvitationMailer.user_invitation
  end

end
