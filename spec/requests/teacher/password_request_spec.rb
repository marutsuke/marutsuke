require 'rails_helper'

RSpec.describe "Teacher::Passwords", type: :request do
  before { teacher_log_in }

  describe '/teacher/password/edit#edit' do
    it 'アクセスできる' do
      get edit_teacher_password_index_path
      expect(response).to have_http_status(200)
    end
  end

end
