class Admin::SessionsController < Admin::Base
  skip_before_action :admin_login_required
  def new
  end

  def create
    admin = Admin.find_by(email: params[:session][:email].downcase)
    if admin&.authenticate(params[:session][:password])
      admin_log_in(admin)
      flash[:success] = 'ログインに成功しました。'
      params[:session][:remember_me] == '1' ? remember_admin(admin) : forget_admin(admin)
      redirect_to admin_users_path
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています。'
      render :new
    end
  end

  def destroy
    admin_log_out if current_admin
    flash[:danger] = 'ログアウトしました。'
    redirect_to admin_login_path
  end
end
