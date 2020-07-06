# frozen_string_literal: true

require 'rails_helper'

describe Teacher::SessionsController, type: :request do
  describe '/teacher/login#new' do
    it '教師ログイン画面を表示する' do
      get teacher_login_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/login#create ' do
    let(:teacher) { create(:teacher) }
    let(:session_params) { { email: teacher.email, password: teacher.password } }

    it 'ログインできる' do
      post teacher_login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include("#{teacher.name}先生、こんにちは!")
      expect(session[:teacher_id]).to eq teacher.id
    end

    it 'フレンドリーフォワーディング' do
      get teacher_lesson_groups_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to teacher_login_path
      post teacher_login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to teacher_lesson_groups_path
    end
  end

  describe '/admin/logout#destroy ' do
    let(:teacher) { create(:teacher) }
    let(:session_params) { { email: teacher.email, password: teacher.password } }

    it 'remember meしないでログイン・ログアウトできる' do
      session_params[:remember_me] = '0'
      post teacher_login_path, params: { session: session_params }
      expect(response.cookies['teacher_remember_token']).to eq nil
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to be_include(teacher.name + '先生')
      expect(session[:teacher_id]).to eq teacher.id
      delete teacher_logout_path
      follow_redirect!
      expect(session[:teacher_id]).to eq nil
    end

    # このテストは、成功するが、ブラウザを閉じる動作が実現できていない
    it 'remember meでログインすると、ブラウザを閉じてもログイン状態を保持できる' do
      session_params[:remember_me] = '1'
      post teacher_login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(response.cookies['teacher_remember_token']).not_to eq nil
      follow_redirect!
      expect(response.body).to be_include(teacher.name + '先生')
      expect(session[:teacher_id]).to eq teacher.id
      session.delete(:teacher_id) # ここで、ブラウザを閉じる動作をしてほしい
      cookies.delete(:teacher_id)
      get new_teacher_teacher_path
      expect(response).to have_http_status(200)
      expect(session[:teacher_id]).to eq teacher.id
    end

    xit 'remember meせずにログインすると、セッションが切れるとログイン状態が保持できない' do
      session_params[:remember_me] = '0'
      post teacher_login_path, params: { session: session_params }
      expect(response).to have_http_status(302)
      expect(response.cookies['teacher_remember_token']).to eq nil
      follow_redirect!
      expect(response.body).to be_include(teacher.name + '先生')
      expect(session[:teacher_id]).to eq teacher.id
      session.delete(:teacher_id) # ここで、ブラウザを閉じる動作をしてほしい
      cookies.delete(:teacher_id)
      expect(session[:teacher_id]).to eq nil
      get new_teacher_teacher_path
      expect(response).to have_http_status(200)
      expect(session[:teacher_id]).to eq nil
    end
  end
end
