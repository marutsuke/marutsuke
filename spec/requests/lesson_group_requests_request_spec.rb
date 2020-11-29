require 'rails_helper'

RSpec.describe "LessonGroupRequests", type: :request do
  let(:user) { create(:user) }
  let(:school) { user.schools.first }
  before { user_log_in(user, school) }

  describe '/lesson_group_requests#index' do
    it 'アクセスできる' do
      get lesson_group_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
