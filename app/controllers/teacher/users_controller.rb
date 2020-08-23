# frozen_string_literal: true

class Teacher::UsersController < Teacher::Base
  before_action :search_users, only: :index

  def index
    @users = @users.page(params[:page])
  end

  def show
    @user = current_teacher_school.users.find(params[:id]).decorate
  end

  private

  def search_users

    @q = current_teacher_school
    .users.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

end
