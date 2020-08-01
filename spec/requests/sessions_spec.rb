# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'SessionsController', type: :request do
  describe '/login/login_path#new' do
    let(:school) { create(:school) }
    it 'ユーザーログイン画面を表示する' do
      get school_login_path(school.login_path)
      expect(response).to have_http_status(200)
    end
  end

  describe '/login_post/:login_path#new' do
    let(:school) { create(:school) }
    it 'ログイン失敗後に、更新して、ユーザーログイン画面を表示する' do
      get login_post_path(school.login_path)
      expect(response).to have_http_status(200)
    end
  end

  describe '/login_post#create ' do
    let(:user) { create(:user) }
    let(:school) { user.schools.first }
    let(:session_params) do
      { password: user.password, school_login_path: school.login_path }
    end
    let(:another_school) { create(:school) }
    let(:lesson) { create(:lesson, school: school) }

    it 'フレンドリーフォワーディング' do
      user_log_in user
      user_log_out
      get lesson_path(lesson)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to school_login_path(login_path: school.login_path)
      session_params[:email_or_login_id] = user.email
      post login_post_path(school.login_path), params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to lesson_path(lesson)
    end

    it 'メールアドレスでログインできる' do
      session_params[:email_or_login_id] = user.email
      post login_post_path(school.login_path), params: { session: session_params }
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include("#{user.name}さん")
      expect(session[:user_id]).to eq user.id
    end

    it 'ログインIDでログインできる' do
      session_params[:email_or_login_id] = user.login_id
      post login_post_path(school.login_path), params: { session: session_params }
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include("#{user.name}さん")
      expect(session[:user_id]).to eq user.id
    end

    it '他校の生徒は、ログインできない' do
      session_params[:email_or_login_id] = user.login_id
      session_params[:school_login_path] = another_school.login_path
      post login_post_path(another_school.login_path), params: { session: session_params }
      expect(response).to have_http_status(200)
      expect(session[:user_id]).not_to eq user.id
    end
  end

  describe '/logout#destroy ' do
    let(:user) { create(:user) }
    let(:school) { user.schools.first }
    let(:session_params) { { email_or_login_id: user.login_id, password: user.password, school_login_path: school.login_path } }

    it 'remember meしないでログイン・ログアウトできる' do
      session_params[:remember_me] = '0'
      post login_post_path(school.login_path), params: { session: session_params }
      expect(response.cookies['teacher_remember_token']).to eq nil
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to be_include(user.name + 'さん')
      expect(session[:user_id]).to eq user.id
      delete logout_path
      expect(response).to have_http_status(302)
    end

    # このテストは、成功するが、ブラウザを閉じる動作が実現できていない(cookieができたかどうかのテストはできている。)
    it 'remember meでログインすると、ブラウザを閉じてもログイン状態を保持できる' do
      session_params[:remember_me] = '1'
      post login_post_path(school.login_path), params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(response.cookies['user_remember_token']).not_to eq nil
      follow_redirect!
      expect(response.body).to be_include(user.name + 'さん')
      expect(session[:user_id]).to eq user.id
      session.delete(:user_id) # これをブラウザを閉じる動作にしたい
      get root_path
      expect(response).to have_http_status(200)
      expect(session[:user_id]).to eq user.id
      expect(response.body).to be_include('予定')
    end

    xit 'remember meせずにログインすると、セッションが切れるとログイン状態が保持できない' do
      session_params[:user_me] = '0'
      post login_post_path(school.login_path), params: { session: session_params }
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
