require 'rails_helper'

RSpec.describe "Teacher::LessonGroupRequests", type: :request do
  let(:teacher) { create(:teacher) }
  before { teacher_log_in(teacher) }

  describe '/teacher/lesson_group_reqeusts#index ' do
    it 'アクセスできる' do
      get teacher_lesson_group_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
