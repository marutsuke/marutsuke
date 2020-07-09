# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teacher::Schools', type: :request do
  let!(:teacher) { create(:teacher) }
  before { teacher_log_in teacher }

  describe 'GET /teacher/schools/:id/edit' do
    it '自分の所属の学校の情報編集にアクセスできる' do
      get edit_teacher_school_path(teacher.school)
      expect(response).to have_http_status(200)
    end
    context '他校の編集画面' do
      let(:another_school) { create(:school) }
      it 'current_schoolで実装しているのでアクセスできる' do
        get edit_teacher_school_path(another_school)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PATCH /teacher/schools/:id' do
    let(:school_params) do
      {
        name: 'after_name',
        login_path: 'login_path'
      }
    end
    it '自分の所属の学校の情報を更新できる' do
      patch teacher_school_path(teacher.school.id),
            params: { school: school_params }

      expect(response).to have_http_status(302)
      expect(response).to redirect_to edit_teacher_school_path(teacher.school)
      expect(teacher.school.reload.name).to eq 'after_name'
    end
  end
end
