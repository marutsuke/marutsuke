# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LessonGroup, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:school_building) }
    it { is_expected.to have_many(:lessons) }
    it { is_expected.to have_many(:lesson_group_users) }
    it { is_expected.to have_many(:users) }
  end
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(30) }

  describe 'scope' do
    describe '#for_school_buildings_belonged_to' do
      subject { LessonGroup.for_school_buildings_belonged_to(teacher) }
      let(:teacher) { create(:teacher) }
      let(:school_building) { create(:school_building) }
      let(:lesson_group) do
        create(:lesson_group, school_building: school_building)
      end
      context '所属校でない講座は含まない' do
        it { is_expected.not_to include(lesson_group) }
      end
      context '所属校の講座は含む' do
        let!(:school_building_teacher) do
          create(:school_building_teacher, teacher: teacher, school_building: school_building)
        end
        it { is_expected.to include(lesson_group) }
      end
    end
  end
end
