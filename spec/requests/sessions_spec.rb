# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'SessionsController', type: :request do
  describe '/login#new' do
    it 'ユーザーログイン画面を表示する' do
      get login_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/login#create ' do
    let(:user) { create(:user) }
    let(:session_params) { { password: user.password } }

    it 'メールアドレスでログインできる' do
      session_params[:email] = user.email
      post login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include("#{user.name}さん")
      expect(session[:user_id]).to eq user.id
    end

    it 'ログインIDでログインできる' do
      session_params[:login_id] = user.login_id
      post login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include("#{user.name}さん")
      expect(session[:user_id]).to eq user.id
    end
  end

  describe '/admin/logout#destroy ' do
    let(:user) { create(:user) }
    let(:session_params) { { login_id: user.login_id, password: user.password } }

    it 'remember meしないでログイン・ログアウトできる' do
      session_params[:remember_me] = '0'
      post login_path, params: { session: session_params }
      expect(response.cookies['teacher_remember_token']).to eq nil
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to be_include(user.name + 'さん')
      expect(session[:user_id]).to eq user.id
      delete logout_path
      follow_redirect!
      expect(session[:user_id]).to eq nil
      expect(response.body).not_to be_include(user.name + 'さん')
    end

    # このテストは、成功するが、ブラウザを閉じる動作が実現できていない(cookieができたかどうかのテストはできている。)
    it 'remember meでログインすると、ブラウザを閉じてもログイン状態を保持できる' do
      session_params[:remember_me] = '1'
      post login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(response.cookies['user_remember_token']).not_to eq nil
      follow_redirect!
      expect(response.body).to be_include(user.name + 'さん')
      expect(session[:user_id]).to eq user.id
      session.delete(:user_id) # これをブラウザを閉じる動作にしたい
      get root_path
      expect(response).to have_http_status(200)
      expect(session[:user_id]).to eq user.id
      expect(response.body).to be_include(user.name + 'さん')
    end

    xit 'remember meせずにログインすると、セッションが切れるとログイン状態が保持できない' do
      session_params[:user_me] = '0'
      post login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(response.cookies['user_remember_token']).to eq nil
      follow_redirect!
      expect(response.body).to be_include(user.name + 'さん')
      expect(session[:user_id]).to eq user.id
      session.delete(:user_id) # ここで、ブラウザを閉じる動作をしてほしい
      expect(session[:user_id]).to eq nil
      get root_path
      expect(response).to have_http_status(200)
      expect(response.body).not_to be_include(user.name + 'さん')
    end
  end
end