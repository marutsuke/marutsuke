# frozen_string_literal: true

class Teacher::TagsController < Teacher::Base
  def new
    @tag = Tag.new
  end

  def create
    @tag = current_school.tags.new(tag_params)
    if @tag.save
      flash[:success] = "タグ: #{@tag.name}を作成しました"
      redirect_to new_teacher_tag_path
    else
      render :new
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
