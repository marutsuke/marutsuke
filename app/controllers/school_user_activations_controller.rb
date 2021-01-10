class SchoolUserActivationsController < UserBase
  skip_before_action :user_login_required, :school_select_required
  before_action :set_school_user_and_user_exist_check, only: %i[new create]

  def edit
    @school_user = SchoolUser.find(params[:id])
    user = @school_user.user
    school = @school_user.school

    if @school_user&.authenticated?(:activation, params[:token]) && @school_user.activated_at.nil?
      @school_user.activate
      @school_user.main_school_building_user_create!
      user_log_in(user, school)
      flash[:success] = "#{school.name}へ参加しました"
      redirect_to root_path
    else
      flash[:danger] = '有効でないリンク、または、すでに参加しています。'
      redirect_to root_path
    end
  end

  def new
    @school = @school_user.school
    @token = params[:token]
    if !@school_user&.authenticated?(:activation, @token) || @school_user.activated_at.present?
      flash[:danger] = '有効でないリンク、または、すでに参加しています。'
      redirect_to root_path
    else
      flash[:success] = "ようこそ！ニックネームとパスワードを設定してください。"
      @new_user_activation_form = NewUserActivationForm.new(@school_user)
    end
  end

  def create
    @new_user_activation_form = NewUserActivationForm.new(@school_user, new_user_activation_form_params)
    @school = @school_user.school
    @token = @new_user_activation_form.school_user_activation_token

    if @new_user_activation_form.save
      user = @school_user.user
      user_log_in(user, @school_user.school)
      params[:remember_me] == '1' ? remember_user(user) : forget_user(user)
      @school_user.activate
      user_log_in(user, @school)
      flash[:success] = "#{@school.name}へ参加しました!"
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def new_user_activation_form_params
    params.require(:new_user_activation_form).permit(:name, :password, :password_confirmation, :school_user_activation_token)
  end

  def set_school_user_and_user_exist_check
    @school_user = SchoolUser.find(params[:school_user_id])
    if User.find_by(email: @school_user.email)
      user_log_in(@school_user.user, @school_user.school)
      redirect_to edit_school_user_activation_url(@school_user, token: params[:token])
    end
  end
end
