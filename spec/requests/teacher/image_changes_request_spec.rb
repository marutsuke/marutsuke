require 'rails_helper'

RSpec.describe "Teacher::ImageChanges", type: :request do
  before { teacher_log_in }

  describe '/teacher/image_changes/edit#index ' do
    it 'アクセスできる' do
      get edit_teacher_image_changes_path
      expect(response).to have_http_status(200)
    end
  end
end
