# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LessonsController', type: :request do
  let(:user) { create(:user) }
  let(:school) { user.schools.first }
  before { user_log_in(user, school) }
  describe '/lessons#index' do
    it 'アクセスできる' do
      get lessons_path
      expect(response).to have_http_status(200)
    end
    context 'ログインしていない' do
      it 'アクセスできない' do
        user_log_out
        get lessons_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_path
      end
    end

    context '未確認の課題をもった授業がある' do
      let!(:going_lesson) { create(:lesson, :going_to, school: school) }
      xit '新しい課題の授業が表示される' do
      end
    end
    context '提出予定の課題がある' do
      let!(:doing_lesson) { create(:lesson, :doing, school: school) }
      xit '提出予定の課題の授業が表示される' do
      end
    end
    context '新しい課題も提出予定の課題もない' do
      xit '特に課題は表示されない' do
      end
    end
  end

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
