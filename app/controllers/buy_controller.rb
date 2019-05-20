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

  def buy
    @book = Book.find(params[:id])
    current_user.books << @book
    redirect_to buy_index_path, notice:"#{@book.title}を購入しました。"
  end

end
