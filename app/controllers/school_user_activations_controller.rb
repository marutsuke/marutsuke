class SchoolUserActivationsController < ApplicationController
  def edit
    @school_user = SchoolUser.find_by(email: params[:email])
    user = @school_user.user
    school = @school_user.school

    if @school_user&.authenticated?(:activation, params[:id]) && @school_user.activated_at.nil?
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

  end
end
