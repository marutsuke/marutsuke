# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teacher::Tags', type: :request do
  before { teacher_log_in }

  describe '/teacher/teachers/new#new' do
    it 'アクセスできる' do
      get new_teacher_tag_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/teachers/new#create' do
    let(:tag_params) { { name: 'タグテスト' }  }
    let(:teacher) { create(:teacher) }
    let(:another_teacher) { create(:teacher) }
    let!(:tag) { create(:tag, name: 'タグテスト', school: teacher.school) }

    context '同じ名前のタグが学校同じ学校にない時' do
      it '同じ学校で同じ名前では、タグを追加作成できない' do
        teacher_log_in(teacher)
        expect do
          post teacher_tags_path, params: { tag: tag_params }
        end.to change(Tag, :count).by(0)
        expect(response).to have_http_status 200
        expect(response.body).to include('タグ名はすでに存在します')
      end

      it '同じ学校でなければ、同じ名前のタグを追加できる' do
        teacher_log_in(another_teacher)
        expect do
          post teacher_tags_path, params: { tag: tag_params }
        end.to change(Tag, :count).by(1)
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_teacher_tag_path
      end
    end
  end
end
