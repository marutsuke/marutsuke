# frozen_string_literal: true

class TeacherMailer < ApplicationMailer
  default from: 'test@test.mail.co.jp'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.teacher_mailer.account_activation.subject
  #
  def account_activation(teacher)
    @teacher = teacher

    mail to: @teacher.email, subject: 'アカウント有効化メール'
  end

  def resend_account_activation(teacher)
    @teacher = teacher

    mail to: @teacher.email, subject: 'アカウント有効化メール[再送]'
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
