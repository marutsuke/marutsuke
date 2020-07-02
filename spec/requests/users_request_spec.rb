# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  before { user_log_in user }

  describe '/users/mypage#maypage' do
    it 'ユーザーmypageを表示する' do
      get mypage_users_path
      expect(response).to have_http_status(200)
    end
  end
end
