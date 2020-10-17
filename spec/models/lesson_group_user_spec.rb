require 'rails_helper'

RSpec.describe LessonGroupUser, type: :model do
  describe '#for_school' do
    subject { LessonGroupUser.for_school(school) }
    let(:user) { create(:user) }
    let(:school_building) { create(:school_building) }
    let(:school) { school_building.school }
    let(:lesson_group) do
      create(:lesson_group, school_building: school_building)
    end
    let(:lesson_group_user) { create(:lesson_group_user, lesson_group: lesson_group, user: user) }
    let(:other_school) { create(:school) }
    let(:other_school_building) { create(:school_building, school: other_school) }
    let(:other_lesson_group) do
      create(:lesson_group, school_building: other_school_building)
    end
    let(:other_lesson_group_user) { create(:lesson_group_user, lesson_group: other_lesson_group, user: user) }

    context '学校の講座は含む' do
      it { is_expected.to include(lesson_group_user) }
    end

    context '学校のものでない講座は含まない' do
      it { is_expected.not_to include(other_lesson_group_user) }
    end
  end
end
