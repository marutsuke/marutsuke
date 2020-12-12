require 'rails_helper'

RSpec.describe "Teacher::SchoolUsers", type: :request do
  let!(:teacher) { create(:teacher) }
  let!(:school_user) { create(:school_user, school: teacher.school) }
  before { teacher_log_in teacher }

  describe 'GET /teacher/school_user/:id/edit' do
    it '学校ユーザーの編集画面にアクセスできる' do
      get edit_teacher_school_user_path(school_user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /teacher/school_users/:id' do
    let(:school_user_params) do
      {
        start_at_date: "2020-01-01", start_at_hour: "0",
        start_at_min: "00",
        end_at_date: "2020-12-31",
        end_at_hour: "23",
        end_at_min: "50"
      }
    end

    it '更新できる' do
      expect(school_user.reload.start_at).not_to eq(Time.new('2020-01-01 0:00:00'))
      patch teacher_school_user_path(school_user),params: { school_user: school_user_params }
      expect(response).to have_http_status(302)
      expect(school_user.reload.start_at).to eq(Time.new('2020-01-01 0:00:00'))
    end
  end
end
