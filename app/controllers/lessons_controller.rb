# frozen_string_literal: true

class LessonsController < ApplicationController
  before_action :set_lessons_scope, only: [:index]
  def index
    @lessons = current_school&.lessons&.send(@scope)
  end

  def show
    @lesson = current_school&.lessons&.find(params[:id])
    @questions = @lesson&.questions
  end

  private

  def set_lessons_scope
    case params[:scope]
    when 'going_to'
      @scope = 'going_to'
      @scope_text = '予定'
    when 'done'
      @scope = 'done'
      @scope_text = '期間中'
    else
      @scope = 'doing'
      @scope_text = '期間中'
    end
  end
end
