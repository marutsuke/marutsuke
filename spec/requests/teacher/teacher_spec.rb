# frozen_string_literal: true

require 'rails_helper'

describe Teacher::TeachersController, type: :request do
  before { teacher_log_in }

  describe '/teacher/teacher#new ' do
    it 'createエラー後更新してもアクセスできる' do
      get '/teacher/teachers'
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/teachers/new#new' do
    it 'アクセスできる' do
      get new_teacher_teacher_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/teachers/new#create' do
    let(:teacher_params) do
      {
        name: 'テスト',
        email: 'test_mail@test.com',
        password: 'password',
        password_confirmation: 'password'
      }
    end
    it '教師を追加作成できる' do
      expect do
        post teacher_teachers_path, params: { teacher: teacher_params }
      end.to change(Teacher, :count).by(1)
      expect(response).to have_http_status 302
      expect(response).to redirect_to new_teacher_teacher_path
    end

    context 'パスワード確認を間違えた時' do
      before { teacher_params[:password] = 'fail_password' }

      it '管理者を作成に失敗したらエラーがでる' do
        expect do
          post teacher_teachers_path, params: { teacher: teacher_params }
        end.to change(Teacher, :count).by(0)
        expect(response).to have_http_status 200
        expect(body).to include('パスワード(確認)と入力が一致しません。')
      end
    end
  end
end
