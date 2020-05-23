# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerImage, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:answer) }
  end
end
