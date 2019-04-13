class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def new
    @books = Book.all
  end


end
