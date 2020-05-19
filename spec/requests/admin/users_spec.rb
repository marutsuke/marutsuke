# frozen_string_literal: true

require 'rails_helper'

describe Admin::UsersController, type: :request do
  before { admin_log_in }

  describe '/admin/users#index' do
    it 'アクセスできる' do
      get '/admin'
      expect(response).to have_http_status(200)
    end
    it 'アクセスできる' do
      get admin_users_path
      expect(response).to have_http_status(200)
    end
    it 'ログインしていなければアクセスできない' do
      admin_log_out
      get admin_users_path
      expect(response).to have_http_status(302)
    end
  end
end
