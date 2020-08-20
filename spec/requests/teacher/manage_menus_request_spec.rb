require 'rails_helper'

RSpec.describe "Teacher::ManageMenus", type: :request do
  let(:teacher) { create(:teacher) }
  before { teacher_log_in(teacher) }

  describe '/teacher/manage_menus#index ' do
    it 'アクセスできる' do
      get teacher_manage_menus_path
      expect(response).to have_http_status(200)
    end
  end
end
