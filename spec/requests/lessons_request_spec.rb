# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LessonsController', type: :request do
  let(:user) { create(:user) }
  let(:school) { user.schools.first }
  before { user_log_in(user, school) }

  describe '/lessons#show' do
    let(:lesson) { create(:lesson, school: school) }
    context '公開中の課題があるとき' do
      let!(:question) { create(:question, :published, lesson: lesson) }
      it 'アクセスできる' do
        get lesson_path(lesson)
        expect(response).to have_http_status(200)
      end
    end
    context '公開中の課題がないとき' do
      let!(:question) { create(:question, :unpublish, lesson: lesson) }
      it 'アクセスできる' do
        get lesson_path(lesson)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to lessons_path
      end
    end
  end
end
