# frozen_string_literal: true

require 'rails_helper'

RSpec.describe School, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:teachers) }
    it { is_expected.to have_many(:lessons) }
    it { is_expected.to have_many(:school_buildings) }
    it { is_expected.to have_many(:users) }
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(20) }
  describe 'validate unqueness of name' do
    let!(:school) { create(:school) }
    it 'is invalid with a duplicate name' do
      school_2 = build(:school, name: school.name)
      expect(school_2).to_not be_valid
    end
  end
end
