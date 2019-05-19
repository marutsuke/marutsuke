class Admin::UsersController < Admin::Base


  def index
    @users = User.where(admin:false)
  end


  def new
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @users = User.all
    if @user.save
      redirect_to new_admin_user_path, notice:"ユーザー「#{@user.name}さん」を登録しました。"
    else
      render :new
    end

  end


  def edit
    @user = User.find(params[:id])
  end

  def show
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to new_admin_user_path, notice:"ユーザー「#{@user.name}さん」の情報を更新しました。"
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_admin_user_path, notice:"ユーザー「#{@user. name}さん」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :login_id, :password, :password_confirmation)
  end


end
