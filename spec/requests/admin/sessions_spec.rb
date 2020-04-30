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

    it 'remember meしないでログイン・ログアウトできる' do
      session_params[:remember_me] = '0'
      post admin_login_path, params: { session: session_params }
      expect(response.cookies['remember_token']).to eq nil
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to be_include(admin.name + 'さん')
      expect(session[:admin_id]).to eq admin.id
      delete admin_logout_path
      follow_redirect!
      expect(session[:admin_id]).to eq nil
      expect(response.body).not_to be_include(admin.name + 'さん')
    end

    it 'remember meしてもログイン・ログアウトできる' do
      session_params[:remember_me] = '1'
      post admin_login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(response.cookies['remember_token']).to_not eq nil
      follow_redirect!
      expect(response.body).to be_include(admin.name + 'さん')
      expect(session[:admin_id]).to eq admin.id
      delete admin_logout_path
      follow_redirect!
      expect(session[:admin_id]).to eq nil
      expect(response.body).not_to be_include(admin.name + 'さん')
    end

    it 'remember meでログインすると、セッションが切れてもログイン状態を保持できる' do
      session_params[:remember_me] = '1'
      post admin_login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(response.cookies['remember_token']).not_to eq nil
      follow_redirect!
      expect(response.body).to be_include(admin.name + 'さん')
      expect(session[:admin_id]).to eq admin.id
      session.delete(:admin_id)
      get admin_users_path
      expect(response).to have_http_status(200)
      expect(session[:admin_id]).to eq admin.id
      expect(response.body).to be_include(admin.name + 'さん')
    end

    xit 'remember meせずにログインすると、セッションが切れるとログイン状態が保持できない' do
      session_params[:remember_me] = '0'
      post admin_login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(response.cookies['remember_token']).to eq nil
      follow_redirect!
      expect(response.body).to be_include(admin.name + 'さん')
      expect(session[:admin_id]).to eq admin.id
      session.delete(:admin_id) ##ここでブラウザ閉じるテストをかきたい
      get admin_users_path
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(session[:admin_id]).to eq nil
      expect(response.body).not_to be_include(admin.name + 'さん')
    end
  end
end
