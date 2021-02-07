require 'rails_helper'

RSpec.describe "Teacher::Mypages", type: :request do
  before { teacher_log_in }

  describe '/teacher/mypage#index' do
    it 'アクセスできる' do
      get teacher_mypage_index_path
      expect(response).to have_http_status(200)
    end
  end
end
