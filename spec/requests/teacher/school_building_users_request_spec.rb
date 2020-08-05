require 'rails_helper'

RSpec.describe "Teacher::SchoolBuildingUsers", type: :request do
  let!(:teacher) { create(:teacher, school: school) }
  let!(:school) { user.schools.first }
  let!(:user) { create(:user) }
  let!(:school_building) { create(:school_building, school: school) }
  let!(:another_school_building) { create(:school_building, school: school) }
  let!(:another_school_building_user) { create(:school_building_user, school_building: another_school_building, user: user, main: true) }
  before { teacher_log_in teacher }

  describe '/teacher/users/:user_id/school_building_users#create' do
    context 'main所属校を追加するときは、他の学校は所属ではなくなる' do
      let(:school_building_user_params) do
        {
          school_building_id: school_building.id,
          main: '1'
        }
      end
      it '所属校を追加' do
        expect do
          post teacher_user_school_building_users_path(user_id: user.id), params: { school_building_user: school_building_user_params }
        end.to change(SchoolBuildingUser, :count).by(1)
        expect(another_school_building_user.reload.main).to be false
      end
    end
    context '他校所属校を追加するときは、他の学校は所属ではなくなる' do
      let(:school_building_user_params) do
        {
          school_building_id: school_building.id,
          main: '0'
        }
      end
      it '所属校を追加' do
        expect do
          post teacher_user_school_building_users_path(user_id: user.id), params: { school_building_user: school_building_user_params }
        end.to change(SchoolBuildingUser, :count).by(1)
        expect(another_school_building_user.reload.main).to be true
      end
    end
  end
end
