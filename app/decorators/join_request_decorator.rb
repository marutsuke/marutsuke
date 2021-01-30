# frozen_string_literal: true

class JoinRequestDecorator < Draper::Decorator
  delegate_all

  def created_at
    super&.strftime('%F-%R')
  end

  def updated_at
    super&.strftime('%F-%R')
  end

end
