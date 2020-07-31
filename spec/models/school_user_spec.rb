require 'rails_helper'

RSpec.describe SchoolUser, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:school) }
  end
  describe 'user_unique_scope_school_building' do
    let(:user) { create(:user) }
    let(:school) { create(:school) }
    let(:another_school) { create(:school) }
    let!(:school_user1) do
      create(:school_user, user: user, school: school)
    end

    it '同じユーザーで、同じ学校は、ダメ' do
      school_user2 = build(
        :school_user, user: user, school: school
      )
      expect(school_user2).to_not be_valid
    end
    it '同じユーザーで、違う校舎は、OK' do
      school_user2 = build(
        :school_user, user: user, school: another_school
      )
      expect(school_user2).to be_valid
    end
  end
end
