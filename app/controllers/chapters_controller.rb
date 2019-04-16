class ChaptersController < ApplicationController

  def show
    set_chapter_section
    respond_to do |format|
      format.html{
      redirect_to action: :root
      }
      format.json
    end
  end

  def new

  end

  def edit

  end

  def create
    create_chapter
    redirect_to controller: 'books',action: 'edit', id: params[:book_id]
  end

  def update

  end

  private

  def set_chapter_section
    @chapter = Chapter.find(params[:chapterid])
    @sections = @chapter.sections
  end

  def create_chapter
    if params[:chapter] != ""
      Chapter.create(chapter:params[:chapter],book_id:params[:book_id])
    end
  end

end