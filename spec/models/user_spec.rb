require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name)
      .with_message("名前を入力してください") }
  end
  describe 'associations' do
    it { is_expected.to belong_to(:school) }
  end
end