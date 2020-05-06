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
        start_at_date: '2020-02-01',
        start_at_hour: '12',
        start_at_min: '30',
        end_at_date: '2021-02-01',
        end_at_hour: '12',
        end_at_min: '30',
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
    context 'アカウント終了日時に関して' do
      it 'end_dateの入力に漏れがある時、終了日時が登録されない' do
        user_params[:end_at_date] = ''
        expect do
          post teacher_users_path, params: { user: user_params }
        end.to change(User, :count).by(1)
        expect(response).to have_http_status 302
        expect(User.last.end_at).to eq nil
      end

      it 'end_dateの入力に漏れがない時、終了日時が登録される' do
        expect do
          post teacher_users_path, params: { user: user_params }
        end.to change(User, :count).by(1)
        expect(response).to have_http_status 302
        expect(User.last.end_at).to eq Time.zone.parse('2021-02-01 12:30:00')
      end
    end
  end
end
