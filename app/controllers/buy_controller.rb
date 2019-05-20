class BuyController < ApplicationController
  def new
  end

  def create
  end

  def index
    @books = Book.all - current_user.books
  end

  def destroy
  end

  def show
    @book = Book.find(params[:id])
  end

end
