# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teacher::Lessons', type: :request do
  let(:teacher) { create(:teacher) }
  before { teacher_log_in(teacher) }

  describe '/teacher/lesson#new ' do
    it 'アクセスできる' do
      get new_teacher_lesson_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/questions#new ' do
    it '講座の問題作成に失敗後、更新をかけると、lessons#indexに飛ばされる' do
      get '/teacher/questions'
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/lesson#new ' do
    it 'ログインしていなければリダイレクトされる' do
      teacher_log_out
      get new_teacher_lesson_path
      expect(response).to have_http_status(302)
    end
  end

  describe '/teacher/lessons#index' do
    it 'アクセスできる' do
      get teacher_lessons_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/lessons#index' do
    it 'アクセスできる' do
      get '/teacher'
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/lessons#create' do
    let(:teacher) { create(:teacher) }
    let(:lesson_params) do
      {
        name: 'テスト',
        start_at_date: '2020-02-01',
        start_at_hour: '12',
        start_at_min: '30',
        end_at_date: '2021-02-01',
        end_at_hour: '12',
        end_at_min: '30',
        teacher_id: teacher.id
      }
    end
    it '講座を作成できる' do
      expect do
        post teacher_lessons_path, params: { lesson: lesson_params }
      end.to change(Lesson, :count).by(1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_teacher_lesson_path
    end
    it '名前がないと作成できない' do
      lesson_params[:name] = ''
      expect do
        post teacher_lessons_path, params: { lesson: lesson_params }
      end.to change(Lesson, :count).by(0)
      expect(response).to have_http_status(200)
      expect(response.body).to include('を入力してください。')
    end

    context 'tagの登録' do
      let!(:tag_1) { create(:tag, name: 'tag1', school: teacher.school) }
      let!(:tag_2) { create(:tag, name: 'tag2', school: teacher.school) }
      let!(:tag_3) { create(:tag, name: 'tag3', school: teacher.school) }
      it 'タグを登録' do
        lesson_params[:tag_ids] = [tag_1.id, tag_2.id]
        expect do
          post teacher_lessons_path, params: { lesson: lesson_params }
        end.to change(Lesson, :count).by(1).and change(LessonTag, :count).by(2)

        expect(response).to have_http_status(302)
      end
    end
  end

  describe '/teacher/lesson#show' do
    let(:lesson) { create(:lesson, teacher: teacher, school: teacher.school) }
    it 'アクセスできる' do
      get teacher_lesson_path(lesson)
      expect(response).to have_http_status(200)
    end
  end
end
