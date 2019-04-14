class SectionsController < ApplicationController

  def show
    set_section_questions
  end

  def new

  end

  def edit

  end

  def create

  end

  def update

  end

  private

  def set_section_questions
    @section = Section.find(params[:id])
    @questions = @section.questions
  end


end
