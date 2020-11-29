require 'rails_helper'

RSpec.describe "Teacher::JoinRequests", type: :request do
  let(:teacher) { create(:teacher) }
  before { teacher_log_in(teacher) }

  describe '/teacher/join_requests#index ' do
    it 'アクセスできる' do
      get teacher_join_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
