class SectionsController < ApplicationController

  def show
    unless current_user
      redirect_to login_path, notice: 'まずはログインをお願いします。'
    end
    set_section_questions
    @correct_numbers = current_user&.correct_numbers&.map{|sq_numbers| sq_numbers.small_question_id}
  end

  def new

  end

  def edit

  end

  def create
    create_section
    redirect_to controller: 'books',action: 'edit', id: params[:book_id]
  end

  def update
    @section = Section.find(params[:id])
    if @section.update(section_params)
      redirect_to new_section_question_path(@section.id)
    end
  end

  private

  def set_section_questions
    @section = Section.includes({questions: [:small_questions]}).find(params[:id])
    @questions = @section.questions
    @chapter = @section.chapter
    @book = @chapter.book
  end

  def create_section
    if params[:section] != ""
      Section.create(section:params[:section],chapter_id:params[:chapter_id])
    end
  end

  def section_params
    params.require(:section).permit(:section)
  end

end
