require 'rails_helper'

describe Admin::SessionsController, type: :request do
  describe '/admin/login#new' do
    it '管理者ログイン画面を表示する' do
      get admin_login_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/admin/login#create ' do
    let(:admin){ create(:admin) }
    let(:session_params){ { email: admin.email, password: admin.password } }

    it 'ログインできる' do
      post admin_login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(session[:admin_id]).to eq admin.id
    end
  end

  describe '/admin/logout#destroy ' do
    let(:admin){ create(:admin) }
    let(:session_params){ { email: admin.email, password: admin.password } }

    it 'ログインアウトできる' do
      post admin_login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(session[:admin_id]).to eq admin.id
      delete admin_logout_path
      expect(session[:admin_id]).to eq nil
    end
  end
end
