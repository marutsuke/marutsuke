require 'rails_helper'

RSpec.describe "UserAccountSettings", type: :request do
  let(:user) { create(:user) }
  before { user_log_in user }

  describe '/user_account_settings#index' do
    it 'ユーザーアカウントページを表示する' do
      get user_account_settings_path
      expect(response).to have_http_status(200)
    end
  end
end
