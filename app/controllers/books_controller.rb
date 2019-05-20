class BooksController < ApplicationController

  def index
    if current_user
      @books = current_user.books.includes(:chapters,:small_questions)
      @small_questions  = SmallQuestion.all
    else
      @books = Book.where(id:1)
    end
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
    if current_user.admin
      @books = Book.includes(:chapters).all
    else
      @books = Book.where(author_id:current_user.id).includes(:chapters)
    end
    @book = Book.new
  end

  def edit
    edit_book
  end

  def create
    @books = Book.includes(:chapters).all
    @book = Book.new(book_params)
    # binding.pry
    if @book.save
       current_user.books << @book
      redirect_to new_book_path, notice: "本を出版しました。"
    else
      render :new
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update!(update_book_params)
    redirect_to action: :edit, id: @book.id
  end

  def destroy
    set_book
    @book.destroy
    redirect_to action: :new
  end

  private

    def book_params
      params.require(:book).permit(:title, :image).merge(rate:0,author_id:current_user.id)
    end

    def set_book_chapter
      if params[:bookid]
        @book = Book.find(params[:bookid])
        @chapters = @book.chapters
      end
    end


    def edit_book
      @book = Book.includes({chapters: [:sections]}).find(params.permit(:id)[:id])
      @chapters = @book.chapters
    end

    def set_book
      @book = Book.find(params.permit(:id)[:id])
    end

    def update_book_params
      params.require(:book).permit(:title,:image)
    end

end
