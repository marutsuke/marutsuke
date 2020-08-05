# frozen_string_literal: true

require 'rails_helper'

describe Teacher::UsersController, type: :request do
  let!(:teacher) { create(:teacher, school: school) }
  before { teacher_log_in teacher }

  describe 'teacher/users#index' do
    context 'userがいる時' do
      let!(:user) { create(:user) }
      let!(:school) { user.schools.first }
      it 'user一覧を表示' do
        get teacher_users_path
        expect(response).to have_http_status(200)
      end
    end
    context 'userがいない時' do
      let!(:school) { create(:school) }
      it 'user一覧を表示' do
        get teacher_users_path
        expect(response.body).to include('生徒はまだいません')
      end
    end
  end
end
