# frozen_string_literal: true

class SchoolUserDecorator < Draper::Decorator
  delegate_all

  def name
    user.name
  end

  def activated_at
    super&.strftime('%F') || '未設定'
  end
end
