# frozen_string_literal: true

class Teacher::UsersController < Teacher::Base
  def index
    @users = current_teacher_school
              .users
              .page(params[:page])
  end

  def show
    @user = current_teacher_school.users.find(params[:id]).decorate
  end

  private

end
