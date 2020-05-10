# frozen_string_literal: true

class LessonsController < ApplicationController
  def index
    @going_lessons = current_school.lessons.going_to
    @doing_lessons = current_school.lessons.doing
    @done_lessons = current_school.lessons.done
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

end
