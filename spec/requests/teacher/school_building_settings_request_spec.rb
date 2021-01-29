require 'rails_helper'

RSpec.describe "Teacher::SchoolBuildingSettings", type: :request do
  let!(:teacher) { create(:teacher) }
  before { teacher_log_in teacher }

  describe 'GET /teacher/school_building_settings' do
    it '校舎設定にアクセスできる' do
      get teacher_school_building_settings_path
      expect(response).to have_http_status(200)
    end
  end
end
