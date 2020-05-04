# frozen_string_literal: true

require 'rails_helper'

describe Teacher::UsersController, type: :request do
  before { teacher_log_in }

  describe '/teacher/users#new ' do
    it 'ログインしていなければ、リダイレクトされる' do
      teacher_log_out
      get '/teacher/users'
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include('ログインしてください')
    end
  end

  describe '/teacher/users#new ' do
    it 'createエラー後更新してもアクセスできる' do
      get '/teacher/users'
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/users#new ' do
    it 'アクセスできる' do
      get new_teacher_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/teachers/new#create' do
    let(:user_params) do
      {
        name: 'テスト',
        email: 'test_mail@test.com',
        start_at: '2020-02-01T01:03',
        end_at: '2021-02-01T01:03',
        password: 'password',
        password_confirmation: 'password'
      }
    end
    it '教師が生徒を追加作成できる' do
      expect do
        post teacher_users_path, params: { user: user_params }
      end.to change(User, :count).by(1)
      expect(response).to have_http_status 302
      expect(response).to redirect_to new_teacher_user_path
    end

    context 'パスワード確認を間違えた時' do
      before { user_params[:password] = 'fail_password' }

      it '管理者を作成に失敗したらエラーがでる' do
        expect do
          post teacher_users_path, params: { user: user_params }
        end.to change(User, :count).by(0)
        expect(response).to have_http_status 200
        expect(body).to include('パスワード(確認)と入力が一致しません。')
      end
    end
  end
end
