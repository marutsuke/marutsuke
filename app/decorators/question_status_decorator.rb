class QuestionStatusDecorator < ApplicationDecorator
  delegate_all

  def status_label
    case status
    when 'unselected'
      html_class = 'a-label--unselected'
    when 'will_do'
      html_class = 'a-label--will-do'
    when 'maybe_do'
      html_class = 'a-label--maybe-do'
    when 'will_not_do'
      html_class = 'a-label--will-not-do'
    when 'checking'
      html_class = 'a-label--checking'
    when 'commented'
      html_class = 'a-label--commented'
    when 'comment_checked'
      html_class = 'a-label--comment-checked'
    when 'complete'
      html_class = 'a-label--complete'
    when 'will_submit_again'
      html_class = 'a-label--will-submit-again'
    end
    h.content_tag :span, class: "a-label #{ html_class }" do
      status_i18n
    end
  end
end
