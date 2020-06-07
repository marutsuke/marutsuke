# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:school) }
    it { is_expected.to have_many(:user_tags) }
    it { is_expected.to have_many(:lesson_tags) }
  end
  it { is_expected.to validate_presence_of(:name) }

  describe 'uniqueness_scope_school' do
    let(:school_1) { create(:school, name: 'test_schol_1') }
    let(:school_2) { create(:school, name: 'test_schol_2') }
    let!(:tag_1) { create(:tag, name: 'tagtest', school: school_1) }

    it '同じ学校で、同じ名前のタグは、ダメ' do
      tag_2 = build(:tag, name: 'tagtest', school: school_1)
      expect(tag_2).to_not be_valid
    end
    it '違う学校で、同じ名前のタグは、OK' do
      tag_3 = build(:tag, name: 'tagtest', school: school_2)
      expect(tag_3).to be_valid
    end
  end
end
