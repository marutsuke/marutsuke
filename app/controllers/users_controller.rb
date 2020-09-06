# frozen_string_literal: true

class UsersController < UserBase
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
    submit_word = params[:button_word]
    if current_user.update(user_params)
      flash[:success] = "#{submit_word}しました。"
      redirect_to mypage_users_path
    else
      flash[:success] = '更新に失敗しました'
      render :mypage
    end
  end

  private
  def user_params
    params.require(:user).permit(:image, :name_kana, :birth_day)
  end

end
