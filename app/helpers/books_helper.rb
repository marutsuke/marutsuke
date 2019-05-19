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

  def rate_book_sm(book,smallquestions)
    correct_count = small_questions.select{|smallquestion|smallquestion.correct_count > 0 && smallquestion.book_id == book.id}.length
    small_question_count = small_questions.select{|smallquestion| smallquestion.book_id == book.id}.length
    if small_question_count != 0
      return (correct_count*100/small_question_count)
    else
      return 0
    end
  end

  def self.category_children(category_id)
    self.data.select{|category_children| category_children[:category_id] == category_id}
  end

end
