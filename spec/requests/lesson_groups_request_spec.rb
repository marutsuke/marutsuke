require 'rails_helper'

RSpec.describe "LessonGroups", type: :request do
  let(:user) { create(:user) }
  let(:school) { user.schools.first }
  before { user_log_in(user, school) }

  describe '/lesson_groups#index' do
    it 'アクセスできる' do
      get lesson_groups_path
      expect(response).to have_http_status(200)
    end
  end
  describe '/lesson_groups#show' do
    let(:lesson_group_user){ create(:lesson_group_user, user: user) }
    it 'アクセスできる' do
      get lesson_group_path(lesson_group_user.lesson_group)
      expect(response).to have_http_status(200)
    end
  end
end
