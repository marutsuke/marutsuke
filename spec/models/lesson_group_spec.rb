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
    describe '#for_school_buildings_belonged_to_teacher' do
      subject { LessonGroup.for_school_buildings_belonged_to_teacher(teacher) }
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
    describe '#for_school_buildings_belonged_to_user' do
      subject { LessonGroup.for_school_buildings_belonged_to_user(user) }
      let(:user) { create(:user) }
      let(:school_building) { create(:school_building) }
      let(:lesson_group) do
        create(:lesson_group, school_building: school_building)
      end
      context '所属校でない講座は含まない' do
        it { is_expected.not_to include(lesson_group) }
      end
      context '所属校の講座は含む' do
        let!(:school_building_user) do
          create(:school_building_user, user: user, school_building: school_building)
        end
        it { is_expected.to include(lesson_group) }
      end
    end
    describe '#for_school_buildings_belonged_to_teacher_and_user' do
      subject { LessonGroup.for_school_buildings_belonged_to_teacher_and_user(teacher, user) }
      let(:user) { create(:user) }
      let(:teacher) { create(:teacher) }
      let(:school_building) { create(:school_building) }
      let(:lesson_group) do
        create(:lesson_group, school_building: school_building)
      end
      context '所属校でない講座は含まない' do
        it { is_expected.not_to include(lesson_group) }
      end
      context 'ユーザーだけが所属校の講座は含まない' do
        let!(:school_building_user) do
          create(:school_building_user, user: user, school_building: school_building)
        end
        it { is_expected.not_to include(lesson_group) }
      end
      context '教員だけが所属校の講座は含まない' do
        let!(:school_building_teacher) do
          create(:school_building_teacher, teacher: teacher, school_building: school_building)
        end
        it { is_expected.not_to include(lesson_group) }
      end
      context 'ユーザー・教員が両方所属校の講座は含む' do
        let!(:school_building_teacher) do
          create(:school_building_teacher, teacher: teacher, school_building: school_building)
        end
        let!(:school_building_user) do
          create(:school_building_user, user: user, school_building: school_building)
        end
        it { is_expected.to include(lesson_group) }
      end
    end
    describe '#for_school' do
      subject { LessonGroup.for_school(school) }
      let(:school_building) { create(:school_building) }
      let(:school) { school_building.school }
      let(:lesson_group) do
        create(:lesson_group, school_building: school_building)
      end
      let(:other_school) { create(:school) }
      let(:other_school_building) { create(:school_building, school: other_school) }
      let(:other_lesson_group) do
        create(:lesson_group, school_building: other_school_building)
      end
      context '該当の学校の講座は含む' do
        it { is_expected.to include(lesson_group) }
      end
      context '該当の学校のものでない講座は含まない' do
        it { is_expected.not_to include(other_lesson_group) }
      end
    end
  end
end
