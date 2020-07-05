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

end
