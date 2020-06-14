require 'rails_helper'

RSpec.describe "Teacher::Tags", type: :request do
  before { teacher_log_in }

  describe '/teacher/teachers/new#new' do
    it 'アクセスできる' do
      get new_teacher_tag_path
      expect(response).to have_http_status(200)
    end
  end

end
