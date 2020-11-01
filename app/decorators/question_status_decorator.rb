class QuestionStatusDecorator < ApplicationDecorator
  delegate_all
  include Rails.application.routes.url_helpers

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

  def checking_link
    case status
    when 'unselected', 'will_do', 'maybe_do', 'will_not_do'
      ''
    else
      h.link_to '詳細', checking_teacher_question_status_answer_checks_path(self)
    end
  end
end
