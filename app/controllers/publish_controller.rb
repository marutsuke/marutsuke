class PublishController < ApplicationController
  def update
    @book = Book.find(params[:id])
    if @book.published
      @book.update(published:false)
      redirect_to new_book_path, notice: "#{@book.title}の販売を中止にしました。"
    else
      @book.update(published:true)
      redirect_to new_book_path, notice: "#{@book.title}を出版しました。"
    end
  end

private

def publish_param
  params.permit(:published)
end

end
