# frozen_string_literal: true

class SchoolDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  def teachers_select_array
    teachers.map { |teacher| [teacher.name, teacher.id] }
  end
end
