# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:answer) }
    it { is_expected.to belong_to(:teacher) }
  end
  it { is_expected.to validate_length_of(:text).is_at_most(800) }
end
