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

  def status_label_link
    path = nil
    case status
    when 'unselected'
      html_class = 'a-label--unselected'
      path = change_to_will_do_question_status_path(self)
    when 'will_do'
      html_class = 'a-label--will-do'
      path = change_to_maybe_do_question_status_path(self)
    when 'maybe_do'
      html_class = 'a-label--maybe-do'
      path = change_to_will_not_do_question_status_path(self)
    when 'will_not_do'
      html_class = 'a-label--will-not-do'
      path = change_to_will_do_question_status_path(self)
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
    if path
      h.link_to status_i18n, path, method: :post, remote: true, class: "a-label #{ html_class }"
    else
      h.content_tag :span, class: "a-label #{ html_class }" do
        status_i18n
      end
    end
  end

  def opacity_class
    if status == 'maybe_do'
      'u-opacity-06'
    elsif status == 'will_not_do'
      'u-opacity-02'
    end
  end

  def status_for_teacher
    case status
    when 'unselected'
      '未選択'
    when 'will_do'
      'する'
    when 'maybe_do'
      'できたらする'
    when 'will_not_do'
      'しない'
    when 'checking'
      h.content_tag :span, class: "a-text-caution" do
        '未チェック'
      end
    when 'commented'
      '教員コメント済み'
    when 'comment_checked'
      '教員コメント既読'
    when 'complete'
      '完了'
    when 'will_submit_again'
      '再提出します'
    end
  end


  def checking_link
    case status
    when 'unselected', 'will_do', 'maybe_do', 'will_not_do'
      ''
    else
      h.link_to '詳細', new_teacher_question_status_comment_path(self), class: 'a-button a-button--secondary'
    end
  end
end
