class SchoolUserActivationsController < ApplicationController
  def edit
    @school_user = SchoolUser.find(params[:id])
    user = @school_user.user
    school = @school_user.school

    if @school_user&.authenticated?(:activation, params[:token]) && @school_user.activated_at.nil?
      @school_user.activate
      user_log_in(user, school)
      flash[:success] = "#{school.name}へ参加しました"
      redirect_to root_path
    else
      flash[:danger] = '有効でないリンク、または、すでに参加しています。'
      redirect_to root_path
    end
  end

  def new
    @school_user = SchoolUser.find_by(email: params[:email])
    @school = @school_user.school
    if !@school_user&.authenticated?(:activation, params[:token]) || @school_user.activated_at.present?
      flash[:danger] = '有効でないリンク、または、すでに参加しています。'
      redirect_to root_path
    end
    flash[:success] = "ようこそ！名前とパスワードを設定してください。"
    @new_user_activation_form = NewUserActivationForm.new(@school_user)
  end

  def create

  end

  private
  def new_user_activation_form_params
    params.require.permit(:name, :password, :password_confirmation, :school_user_activation_token)
  end
end
