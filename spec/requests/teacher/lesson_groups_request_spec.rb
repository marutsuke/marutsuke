require 'rails_helper'

RSpec.describe "Teacher::LessonGroups", type: :request do

  let(:teacher) { create(:teacher) }
  before { teacher_log_in(teacher) }

  describe '/teacher/lesson_groups#new ' do
    let!(:lesson_groups){ create(:lesson_group) }
    it 'アクセスできる' do
      get teacher_lesson_groups_path
      expect(response).to have_http_status(200)
    end
  end

end
