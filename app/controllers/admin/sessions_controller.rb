class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    @admin = Admin.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
    else
      flash[:danger] = 'メールアドレスまたはパスワードが間違っています。'
      render :new
    end
  end

  def destroy
  end
end
