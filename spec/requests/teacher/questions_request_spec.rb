# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teacher::Questions', type: :request do
  let(:teacher) { create(:teacher) }
  before { teacher_log_in(teacher) }

  describe '/teacher/questions#create' do
    let(:lesson) { create(:lesson, teacher: teacher, school: teacher.school) }
    let(:question_params) do
      {
        title: 'テスト',
        text: 'aaaaaaaaaaaaaa',
        image: '',
        lesson_id: lesson.id
      }
    end
    it '問題を追加作成できる' do
      expect do
        post teacher_questions_path, params: { question: question_params }
      end.to change(Question, :count).by(1)
      expect(response).to have_http_status 302
      expect(response).to redirect_to teacher_lesson_path(lesson)
    end
  end
end
