require 'rails_helper'

RSpec.describe "JoinRequests", type: :request do
  let(:user) { create(:user) }
  let(:school) { user.schools.first }
  before { user_log_in(user, school) }

  describe '/join_requests/new#new' do
    it 'アクセスできる' do
      get new_join_request_path
      expect(response).to have_http_status(200)
    end
  end
end
