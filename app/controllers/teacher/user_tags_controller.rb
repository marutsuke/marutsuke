# frozen_string_literal: true

class Teacher::UserTagsController < ApplicationController
  def create
    @user_tag = UserTag.new(user_tag_params)
    @user = @user_tag.user
    respond_to do |format|
      if @user_tag.save && current_school.users.find_by(id: @user.id)
        format.js # create.js.erb
      else
        flash[:danger] = 'タグ登録に失敗しました。もう一度試してください。解決しない場合は、お問い合わせください。'
        redirect_to teacher_user_path(user_tag.user)
      end
    end
  end

  private

  def user_tag_params
    params.require(:user_tag).permit(:tag_id, :user_id)
  end
end
