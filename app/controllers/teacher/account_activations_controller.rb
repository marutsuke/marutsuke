# frozen_string_literal: true

class Teacher::AccountActivationsController < Teacher::Base
  skip_before_action :teacher_login_required

  def edit
    @teacher = Teacher.find_by(email: params[:email])
    if @teacher&.authenticated?(:activation, params[:id]) && !@teacher.activated?
      @teacher.activate
      teacher_log_in(@teacher)
      flash[:success] = 'アカウントが有効になりました。'
      redirect_to teacher_path
    else
      binding.pry
      flash[:danger] = '有効でないリンクです。'
    end
  end
end
