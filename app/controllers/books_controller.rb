class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    set_book_chapter
    respond_to do |format|
      format.html{
      redirect_to action: :index
      }
      format.json
    end
  end

  def new
    @books = Book.all
  end

  def edit

  end

  def create

  end

  def update

  end

  def destroy

  end
  private

    def set_book_chapter
      if params[:bookid]
        @book = Book.find(params[:bookid])
        @chapters = @book.chapters
      end
    end

end
