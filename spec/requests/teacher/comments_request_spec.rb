# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teacher::Comments', type: :request do
  let(:teacher) { create(:teacher) }
  before { teacher_log_in(teacher) }

  describe '/teacher/comments#create' do
    let(:answer) { create(:answer) }
    let(:comment_params) do
      {
        text: 'aaaaaaaaaaaaaa',
        image: '',
        answer_id: answer.id
      }
    end
    it 'コメントを追加できる' do
      expect do
        post teacher_comments_path, params: { comment: comment_params }
      end.to change(Comment, :count).by(1)
      expect(response).to have_http_status 302
      expect(response).to redirect_to teacher_question_path(answer.question)
    end
  end
end
