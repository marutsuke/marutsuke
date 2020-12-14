class UserNotificationMailer < ApplicationMailer
  def notification_of_comment(comment)
    return unless comment.answer.user.user_authentication.provider == 'email'

    @comment = comment
    @text = comment.text
    @teacher = comment.teacher
    mail to: comment.answer.user.user_authentication.uid, subject: "[Marutsuke]コメントがあります"
  end
end
