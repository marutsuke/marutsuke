module QuestionStatusHelper

  def will_do_button(word ,question, remote: false, option_class: '')
    link_to word, will_do_question_question_statuses_path(question), class: "a-button-primary #{ option_class }", method: :post, remote: remote
  end

  def maybe_do_button(word ,question, remote: false, option_class: '')
    link_to word, maybe_do_question_question_statuses_path(question), class: "a-button-secondary #{ option_class }", method: :post, remote: remote
  end

  def will_not_do_button(word ,question, remote: false, option_class: '')
    link_to word, will_not_do_question_question_statuses_path(question), class: "a-button-danger #{ option_class }", method: :post, remote: remote
  end

end
