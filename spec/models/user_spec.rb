# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(20) }
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

  describe '#main_school_building' do
    let!(:user) { create(:user) }
    let!(:school){ create(:school) }
    let!(:school_2){ create(:school) }
    let!(:school_user) { create(:school_user, user: user, school: school ) }
    let!(:school_user_2) { create(:school_user, user: user, school: school_2 ) }
    let!(:school_building_1) { create(:school_building, school: school) }
    let!(:school_building_2) { create(:school_building, school: school) }
    let!(:school_building_2_1) { create(:school_building, school: school_2) }
    let!(:school_building_2_2) { create(:school_building, school: school_2) }
    let!(:school_building_user_1){ create(:school_building_user, school_building: school_building_1, user: user, main: true) }
    let!(:school_building_user_2){ create(:school_building_user, :sub, school_building: school_building_2, user: user) }
    let!(:school_building_user_2_1){ create(:school_building_user, school_building: school_building_2_1, user: user, main: true) }
    let!(:school_building_user_2_2){ create(:school_building_user, :sub, school_building: school_building_2_2, user: user, main: true) }
    it { expect(user.main_school_building(school)).to eq school_building_1 }
  end

  describe '#lesson_groups_in(school)' do
    subject { user.lesson_groups_in(school) }
    let(:user) { create(:user) }
    let!(:school){ create(:school) }
    let!(:school_2){ create(:school) }
    let!(:school_building) { create(:school_building, school: school) }
    let!(:school_building_in_other_school) { create(:school_building, school: school_2) }

    context "その学校の講座の時、含む" do
      let!(:lesson_group) {  create(:lesson_group, school_building: school_building) }
      let!(:lesson_group_user) { create(:lesson_group_user, user: user,  lesson_group: lesson_group) }

      it { is_expected.to include(lesson_group)}
    end

    context "他の学校の講座の時、含まない" do
      let!(:lesson_group) {  create(:lesson_group, school_building: school_building_in_other_school) }
      let!(:lesson_group_user) { create(:lesson_group_user, user: user,  lesson_group: lesson_group) }

      it { is_expected.not_to include(lesson_group)}
    end

  end

end
