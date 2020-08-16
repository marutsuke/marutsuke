class QuestionDecorator < ApplicationDecorator
  delegate_all

  def unpublish_opacity_class
    publish? ? '' : 'opacity4'
  end

end
