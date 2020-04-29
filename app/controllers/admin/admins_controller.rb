class Admin::AdminsController < Admin::Base
  def new
    @admin = Admin.new
  end

  def show
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  private
  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end
end
