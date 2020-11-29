class UserActivationMailer < ApplicationMailer
  def user_activation(user_authentication)
    @user_authentication = user_authentication
    mail to: user_authentication.uid, subject: "[Marutsuke]へようこそ！あと少しで登録完了！"
  end
end
