require 'rails_helper'

RSpec.describe "Teacher::Menus", type: :request do
  let(:teacher) { create(:teacher) }
  before { teacher_log_in(teacher) }

  describe '/teacher/menus#regular_work' do
    it 'アクセスできる' do
      get regular_work_teacher_menus_path
      expect(response).to have_http_status(200)
    end
  end
  describe '/teacher/menus#school_building_manage' do
    it 'アクセスできる' do
      get school_building_manage_teacher_menus_path
      expect(response).to have_http_status(200)
    end
  end
  describe '/teacher/menus#school_building_analysis' do
    it 'アクセスできる' do
      get school_building_analysis_teacher_menus_path
      expect(response).to have_http_status(200)
    end
  end
  describe '/teacher/menus#school_manage' do
    it 'アクセスできる' do
      get school_manage_teacher_menus_path
      expect(response).to have_http_status(200)
    end
  end
end
