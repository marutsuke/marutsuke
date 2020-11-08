# frozen_string_literal: true

class SessionsController < UserBase
  skip_before_action :user_login_required, :school_select_required

  def new
    @school = School.find_by(login_path: params[:login_path])
    raise ActiveRecord::RecordNotFound unless @school
  end

  def create
    @school = School.find_by(login_path: session_params[:school_login_path])
    user = search_user_from_email(@school)
    if user&.authenticate(session_params[:password])
      user_log_in(user, @school)
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      flash[:success] = "#{user.name}さん、こんにちは!"
      redirect_back_or root_path
    else
      flash.now[:danger] = 'ログインに失敗しました。正しいか確認してもう一度ログインをお願いします。'
      render :new
    end
  end

  def destroy
    @school = current_school
    user_log_out
    flash[:danger] = 'ログアウトしました。'
    redirect_to school_login_path(@school.login_path)
  end

  private

  def session_params
    params.require(:session)
          .permit(:password, :email, :school_login_path)
  end

  def search_user_from_email(school)
    return nil if school.nil?

    user = school.users.find_by(email: session_params[:email])
  end
end
