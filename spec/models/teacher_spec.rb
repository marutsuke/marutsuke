require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:school) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(12) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(50) }
    it do
      is_expected.to allow_values('first.last@foo.jp',
                                  'user@example.com',
                                  'USER@foo.COM',
                                  'A_US-ER@foo.bar.org',
                                  'alice+bob@baz.cn').for(:email)
    end
    it do
      is_expected.to_not allow_values('user@example,com',
                                      'user_at_foo.org',
                                      'user.name@example.',
                                      'foo@bar,_baz.com',
                                      'foo@bar+baz.com').for(:email)
    end
    describe 'validate unqueness of email' do
      let!(:admin) { create(:admin, email: 'original@example.com') }
      it 'is invalid with a duplicate email' do
        admin = build(:admin, email: 'original@example.com')
        expect(admin).to_not be_valid
      end
      it 'is case insensitive in email' do
        admin = build(:admin, email: 'ORIGINAL@EXAMPLE.COM')
        expect(admin).to_not be_valid
      end
    end
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end
  it { is_expected.to have_secure_password }
  describe 'before_save' do
    describe '#email_downcase' do
      let!(:admin) { create(:admin, email: 'ORIGINAL@EXAMPLE.COM') }
      it 'makes email to low case' do
        expect(admin.reload.email).to eq 'original@example.com'
      end
    end
  end

end
