class TeacherNotificationMailer < ApplicationMailer
  def notification_of_answer(answer)
    @answer = answer
    @question = @answer.question
    @user = answer.user
    @lesson = answer.question.lesson
    @teacher = @lesson.teacher
    mail to: @teacher.email, subject: "[Marutsuke]提出がありました"
  end
end
