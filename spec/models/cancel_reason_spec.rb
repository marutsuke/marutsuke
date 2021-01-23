require 'rails_helper'

RSpec.describe CancelReason, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).optional }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:reason) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:confirm) }
  end
end
