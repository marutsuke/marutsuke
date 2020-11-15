# frozen_string_literal: true

class UsersController < UserBase
  skip_before_action :school_select_required,
                     only: :mypage
  skip_before_action :user_login_required,
                     :school_select_required,
                     only: :new
  before_action :user_log_out_required, only: %i[new]

  def mypage; end

  def change_school
    school = current_user.schools.find(params[:school_id])
    user_log_in(current_user, school)
    flash[:success] = "#{school.name}に切り替えました"
    redirect_to root_path
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "更新しました。"
      redirect_to mypage_users_path
    else
      flash[:success] = '更新に失敗しました'
      render :mypage
    end
  end

  def new
  end

  private
  def user_params
    params.require(:user).permit(:image, :name, :name_kana, :email, :birth_day, :school_grade)
  end
end
