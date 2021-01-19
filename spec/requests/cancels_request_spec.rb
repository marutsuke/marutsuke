require 'rails_helper'

RSpec.describe "Cancels", type: :request do
  let(:user) { create(:user) }
  before { user_log_in user }
  describe '/cancels#new' do
    it 'ユーザー退会ページを表示する' do
      get new_cancel_path
      expect(response).to have_http_status(200)
    end
  end
end
