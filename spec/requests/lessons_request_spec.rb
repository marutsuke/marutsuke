# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LessonsController', type: :request do
  let(:user) { create(:user) }
  before { user_log_in user }
  describe '/lessons#index' do
    it 'アクセスできる' do
      get lessons_path
      expect(response).to have_http_status(200)
    end
    context 'ログインしていない' do
      it 'アクセスできない' do
        user_log_out
        get lessons_path
        expect(response).to have_http_status(302)
      end
    end

    context '開催予定の授業だけがある' do
      let!(:going_lesson) { create(:lesson, :going_to, school: user.school) }
      it '開催予定の授業が表示される' do
        get lessons_path
        expect(response).to have_http_status(200)
        expect(response.body).to include(going_lesson.name)
        expect(response.body).to include('現在、開催中の授業・講座は登録されていません。')
        expect(response.body).to include('現在、期間終了の授業・講座は登録されていません。')
      end
    end
    context '開催中の授業だけがある' do
      let!(:doing_lesson) { create(:lesson, :doing, school: user.school) }
      it '開催中の授業が表示される' do
        get lessons_path
        expect(response).to have_http_status(200)
        expect(response.body).to include(doing_lesson.name)
        expect(response.body).to include('現在、開催予定の授業・講座は登録されていません。')
        expect(response.body).to include('現在、期間終了の授業・講座は登録されていません。')
      end
    end
    context '開催終了の授業だけがある' do
      let!(:done_lesson) { create(:lesson, :done, school: user.school) }
      it '開催終了の授業が表示される' do
        get lessons_path
        expect(response).to have_http_status(200)
        expect(response.body).to include(done_lesson.name)
        expect(response.body).to include('現在、開催予定の授業・講座は登録されていません。')
        expect(response.body).to include('現在、開催中の授業・講座は登録されていません。')
      end
    end
    context '他の学校の授業だけがある' do
      let!(:going_lesson) { create(:lesson, :going_to) }
      let!(:doing_lesson) { create(:lesson, :doing) }
      let!(:done_lesson) { create(:lesson, :done) }
      it '開催中の授業はない' do
        get lessons_path
        expect(response).to have_http_status(200)
        expect(response.body).to include('現在、開催予定の授業・講座は登録されていません。')
        expect(response.body).to include('現在、開催中の授業・講座は登録されていません。')
        expect(response.body).to include('現在、期間終了の授業・講座は登録されていません。')
      end
    end
  end

  describe '/lessons#show' do
    let(:lesson) { create(:lesson, school: user.school) }
    it 'アクセスできる' do
      get lesson_path(lesson)
      expect(response).to have_http_status(200)
    end
  end
end
