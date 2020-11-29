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
    context 'ログインしていない' do
      it 'アクセスできない' do
        user_log_out
        get lesson_groups_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_path
      end
    end
  end
end
