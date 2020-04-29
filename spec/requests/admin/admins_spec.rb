require 'rails_helper'

describe Admin::AdminsController, type: :request do
  describe '/admin/admins#new ' do
      it 'createエラー後更新してもアクセスできる' do
      get '/admin/admins'
      expect(response).to have_http_status(200)
    end
  end

  describe '/admin/admins/new#new' do
    it 'アクセスできる' do
      get new_admin_admin_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/admin/admins/new#create' do
    let(:admin_params){ {
        name: "テスト",
        email: "test_mail@test.com",
        password: 'password',
        password_confirmation: 'password'
      }
    }
    it '管理者を作成できる' do
      expect {
        post admin_admins_path, params: { admin: admin_params }
      }.to change(Admin, :count).by(1)
      expect(response).to have_http_status 302
      expect(response).to redirect_to admin_users_path
    end

    context 'パスワード確認を間違えた時' do
      before { admin_params[:password] = 'fail_password' }

      it '管理者を作成に失敗したらエラーがでる' do
        expect {
          post admin_admins_path, params: { admin: admin_params }
        }.to change(Admin, :count).by(0)
        expect(response).to have_http_status 200
        expect(body).to include('パスワード(確認)と入力が一致しません。')
      end
    end
  end
end
