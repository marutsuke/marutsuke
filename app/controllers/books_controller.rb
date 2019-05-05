class BooksController < ApplicationController

  def index
    @books = Book.includes(:chapters,:small_questions).all
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
    @books = Book.includes(:chapters).all
  end

  def edit
    edit_book
  end

  def create
    new_book_create
    redirect_to action: :new
  end

  def update

  end

  def destroy
    set_book
    @book.destroy
    redirect_to action: :new
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
        Book.create(book_params)
      end
    end

    def edit_book
      @book = Book.includes({chapters: [:sections]}).find(params.permit(:id)[:id])
      @chapters = @book.chapters
    end

    def set_book
      @book = Book.find(params.permit(:id)[:id])
    end

end
