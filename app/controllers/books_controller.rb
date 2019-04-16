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
    edit_book
  end

  def create
    new_book_create
    redirect_to action: :index
  end

  def update

  end

  def destroy

  end
  private

    def book_params
      params.permit(:title, :image).merge(rate:0)
    end

    def set_book_chapter
      if params[:bookid]
        @book = Book.find(params[:bookid])
        @chapters = @book.chapters
      end
    end

    def new_book_create
      if params[:title] != ""
      Book.create(title:params[:title], rate: 0)
      end
    end

    def edit_book
      @book = Book.find(params.permit(:id)[:id])
      @chapters = @book.chapters
    end

end

