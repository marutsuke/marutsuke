# frozen_string_literal: true

class TagDecorator < ApplicationDecorator
  delegate_all

  def user_tagged_mark(user)
    user.tagged_for?(self) ? '○' : ''
  end
end
