# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teacher::Comments', type: :request do
  let(:teacher) { create(:teacher, school: question.lesson.school) }
  let(:question) { question_status.question }
  let!(:question_status) { create(:question_status, :checking) }
  let!(:answer) { create(:answer, question: question, user: question_status.user) }
  before { teacher_log_in(teacher) }

  describe '/teacher/question_statuses/:question_status_id/comments/new#new ' do
    it 'アクセスできる' do
      get new_teacher_question_status_comment_path(question_status)
      expect(response).to have_http_status(200)
    end
  end


  describe '/teacher/question_statuses/:question_status_id/comments#create' do
    let(:comment_params) do
      {
        text: 'aaaaaaaaaaaaaa',
        image: '',
        answer_id: answer.id
      }
    end
    context "validation通過時" do
      it 'コメントを追加できる' do
        expect do
          post teacher_question_status_comments_path(question_status), params: { comment: comment_params }
        end.to change(Comment, :count).by(1)
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_teacher_question_status_comment_path(question_status)
      end
    end
    context 'validationに引っかかる時' do
      before { comment_params[:text] = '' }
      it 'エラーが表示される' do
        expect do
          post teacher_question_status_comments_path(question_status), params: { comment: comment_params }
        end.to change(Comment, :count).by(0)
        expect(response).to have_http_status 200
        expect(response.body).to include('入力してください')
      end
    end
  end
end
