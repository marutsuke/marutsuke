# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teacher::Questions', type: :request do
  let(:teacher) { create(:teacher) }
  before { teacher_log_in(teacher) }

  describe '/teacher/questions#create' do
    let(:lesson) { create(:lesson, teacher: teacher, school: teacher.school) }
    let(:question_params) do
      {
        text: 'aaaaaaaaaaaaaa',
        image: '',
        lesson_id: lesson.id
      }
    end
    context 'validation通過の時' do
      it '問題を追加作成できる' do
        expect do
          post teacher_questions_path, params: { question: question_params }
        end.to change(Question, :count).by(1)
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_teacher_lesson_question_path(lesson)
      end
    end
    context 'バリデーションに引っかかる時' do
      before { question_params[:text] = '' }
      it '問題を追加バリデーションエラーを表示' do
        question_params
        expect do
          post teacher_questions_path, params: { question: question_params }
        end.to change(Question, :count).by(0)
        expect(response).to have_http_status 200
        expect(response.body).to include('入力してください')
      end
    end
  end
end
