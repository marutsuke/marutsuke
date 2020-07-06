# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchoolBuilding, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:school) }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(20) }
  end
  describe 'name_unique_scope_school' do
    let(:school_1) { create(:school, name: 'test_schol_1') }
    let(:school_2) { create(:school, name: 'test_schol_2') }
    let!(:school_building) { create(:school_building, name: 'name_1', school: school_1) }

    it '同じ学校で、同じ名前のログインIDは、ダメ' do
      school_building_2 = build(:school_building, name: 'name_1', school: school_1)
      expect(school_building_2).to_not be_valid
    end
    it '違う学校で、同じログインIDは、OK' do
      school_building_3 = build(:school_building, name: 'name_3', school: school_2)
      expect(school_building_3).to be_valid
    end
  end
end
