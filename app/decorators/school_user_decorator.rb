# frozen_string_literal: true

class SchoolUserDecorator < Draper::Decorator
  delegate_all

  def name
    user.name
  end

  def activated_at
    super&.strftime('%F-%R') || '未設定'
  end

  def activated
    if super
      h.content_tag :span, class: "" do
        '有効'
      end
    else
      h.content_tag :span, class: "a-text-caution" do
        '無効'
      end
    end
  end

  def start_at
    super&.strftime('%F-%R') || '未設定'
  end

  def end_at
    super&.strftime('%F-%R') || '未設定'
  end
end
