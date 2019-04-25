module BooksHelper
  def rate_book(book)
    correct_count = SmallQuestion.where(book_id: book.id).where('correct_count > ?',0).length
    small_question_count = book.small_questions.length
    if small_question_count != 0
      return (correct_count*100/small_question_count)
    else
      return 0
    end
  end

end