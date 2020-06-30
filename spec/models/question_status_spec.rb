# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionStatus, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:question) }
    it { is_expected.to validate_presence_of(:status) }
  end
end