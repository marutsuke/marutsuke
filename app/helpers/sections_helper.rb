module SectionsHelper
  def rate(section)
    correct_count = SmallQuestion.where(section_id: section.id).where('correct_count > ?',0).length
    small_question_count = section.small_questions.length
    if small_question_count != 0
    return (correct_count*100/small_question_count)
    else
      return 0
    end
  end
end
