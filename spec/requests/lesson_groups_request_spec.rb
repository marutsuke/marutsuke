require 'rails_helper'

RSpec.describe "LessonGroups", type: :request do
  let(:user) { create(:user) }
  let(:school) { user.schools.first }
  before { user_log_in(user, school) }

  describe '/lesson_groups#index' do
    it 'アクセスできるアクセスできるアクセスして' do
      get lesson_groups_path
      expect(response).to have_http_status(200)
    end
  end
end
