# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LessonTag, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:lesson) }
    it { is_expected.to belong_to(:tag) }
  end
end
