# frozen_string_literal: true

class TeacherMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.teacher_mailer.account_activation.subject
  #
  def account_activation(teacher)
    @teacher = teacher

    mail to: @teacher.email, subject: 'アカウント有効化メール'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.teacher_mailer.password_reset.subject
  #
  def password_reset
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end
end
