class Admin::SessionsController < Admin::Base
  skip_before_action :admin_login_required
  def new
  end

  def create
    @admin = Admin.find_by(email: params[:session][:email].downcase)
    if @admin&.authenticate(params[:session][:password])
      admin_log_in(@admin)
      flash[:success] = 'ログイン成功に成功しました。'
      redirect_to admin_users_path
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています。'
      render :new
    end
  end

  def destroy
    admin_log_out
    flash[:danger] = 'ログアウトしました。'
    redirect_to admin_users_path
  end
end
