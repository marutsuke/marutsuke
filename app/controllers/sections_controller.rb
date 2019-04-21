class SectionsController < ApplicationController

  def show
    set_section_questions
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

  end

  private

  def set_section_questions
    @section = Section.includes({questions: [:small_questions]}).find(params[:id])
    @questions = @section.questions
  end

  def create_section
    if params[:section] != ""
      Section.create(section:params[:section],chapter_id:params[:chapter_id])
    end
  end


end
