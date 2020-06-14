# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SchoolsController', type: :request do
  describe '/schools#new' do
    it 'create失敗後に更新してもアクセスできる' do
      get '/schools'
      expect(response).to have_http_status(200)
    end
  end

  describe '/schools#new' do
    it 'アクセスできる' do
      get new_school_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/schools#create' do
    let(:school_params) do
      {
        name: 'テスト',
        login_path: 'login_path_test',
        teacher: {
          name: 'テスト',
          email: 'test@test.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end
    it '学校と教師を同時に作成できる' do
      expect do
        post schools_path, params: { school: school_params }
      end.to change { School.count + Teacher.count }.by(2)
      expect(response).to have_http_status 302
      expect(response).to redirect_to new_teacher_teacher_path
    end

    context 'パスワード確認を間違えた時' do
      before { school_params[:teacher][:password] = 'fail_password' }

      it '教師を作成に失敗したらエラーがでる' do
        expect do
          post schools_path, params: { school: school_params }
        end.to change { School.count + Teacher.count }.by(0)
        expect(response).to have_http_status 200
        expect(body).to include('パスワード(確認)と入力が一致しません。')
      end
    end
    context '同じ名前の学校がある時' do
      let!(:school) { create(:school, name: 'テスト') }

      it '教師を作成に失敗したらエラーがでる' do
        expect do
          post schools_path, params: { school: school_params }
        end.to change { School.count + Teacher.count }.by(0)
        expect(response).to have_http_status 200
        expect(body).to include('学校名・塾名はすでに存在します')
      end
    end
  end
end
