# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(12) }
    it { is_expected.to validate_length_of(:email).is_at_most(50) }
    it do # email is allowed nil,uniqueness: true
      is_expected.to allow_values('first.last@foo.jp',
                                  'user@example.com',
                                  'USER@foo.COM',
                                  'A_US-ER@foo.bar.org',
                                  'alice+bob@baz.cn',
                                  nil).for(:email)
    end
    it do
      is_expected.to_not allow_values('user@example,com',
                                      'user_at_foo.org',
                                      'user.name@example.',
                                      'foo@bar,_baz.com',
                                      'foo@bar+baz.com').for(:email)
    end
    describe 'validate unqueness of email' do
      let!(:user) { create(:user, email: 'original@example.com') }
      it 'is invalid with a duplicate email' do
        user_2 = build(:user, email: 'original@example.com')
        expect(user_2).to_not be_valid
      end
      it 'is case insensitive in email' do
        user_2 = build(:user, email: 'ORIGINAL@EXAMPLE.COM')
        expect(user_2).to_not be_valid
      end
    end
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    describe 'login_id_scope_school' do
      let(:school_1) { create(:school, name: 'test_schol_1') }
      let(:school_2) { create(:school, name: 'test_schol_2') }
      let!(:user) { create(:user, login_id: 'login_id', school: school_1) }

      # it '同じ学校で、同じ名前のログインIDは、ダメ' do
      #   user_2 = build(:user, login_id: 'login_id', school: school_1)
      #   expect(user_2).to_not be_valid
      # end
      # it '違う学校で、同じログインIDは、OK' do
      #   user_3 = build(:user, login_id: 'login_id', school: school_2)
      #   expect(user_3).to be_valid
      # end
    end
  end
  it { is_expected.to have_secure_password }

  describe 'associations' do
    it { is_expected.to have_many(:school_users) }
  end
  describe 'before_save' do
    describe '#email_downcase' do
      let!(:user) { create(:user, email: 'ORIGINAL@EXAMPLE.COM') }
      it 'makes email to low case' do
        expect(user.reload.email).to eq 'original@example.com'
      end
    end
  end
  describe 'scope' do
  end
end
