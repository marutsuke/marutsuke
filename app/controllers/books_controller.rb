class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
  if params[:bookid]
    @book = Book.find(params[:bookid])
    @chapters = @book.chapters
  end
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


end
