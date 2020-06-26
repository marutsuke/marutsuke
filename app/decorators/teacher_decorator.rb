# frozen_string_literal: true

class TeacherDecorator < Draper::Decorator
  delegate_all

  def activated_status
    activated ? '有効' : '無効'
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
end
