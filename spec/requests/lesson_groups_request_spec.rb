require 'rails_helper'

RSpec.describe "LessonGroups", type: :request do
  let(:user) { create(:user) }
  let(:school) { user.schools.first }
  let(:school_building){ create(:school_building, school: school) }
  let(:school_building_user){ create(:school_building_user, school_building: school_building, user: user) }
  before { user_log_in(user, school) }

  describe '/lesson_groups#index' do
    it 'アクセスできる' do
      get lesson_groups_path
      expect(response).to have_http_status(200)
    end
  end
  describe '/lesson_groups#show' do
    let!(:lesson_group){ create(:lesson_group, school_building: school_building) }
    let!(:lesson_group_user){ create(:lesson_group_user, user: user, lesson_group: lesson_group) }
    it 'アクセスできる' do
      get lesson_group_path(lesson_group)
      expect(response).to have_http_status(200)
    end
  end
end
