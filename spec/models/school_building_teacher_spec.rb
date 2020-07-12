# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchoolBuildingTeacher, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:teacher) }
    it { is_expected.to belong_to(:school_building) }
  end
  describe 'teacher_unique_scope_school_building' do
    let(:teacher) { create(:teacher) }
    let(:school_building) { create(:school_building) }
    let(:another_school_building) { create(:school_building) }
    let!(:school_building_teacher1) do
      create(:school_building_teacher, teacher: teacher, school_building: school_building)
    end

    it '同じユーザーで、同じ校舎は、ダメ' do
      school_building_teacher2 = build(
        :school_building_teacher, teacher: teacher, school_building: school_building
      )
      expect(school_building_teacher2).to_not be_valid
    end
    it '同じユーザーで、違う校舎は、OK' do
      school_building_teacher2 = build(
        :school_building_teacher, teacher: teacher, school_building: another_school_building
      )
      expect(school_building_teacher2).to be_valid
    end
  end
end
