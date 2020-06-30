# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:school) }
    it { is_expected.to belong_to(:teacher) }
    it { is_expected.to have_many(:questions) }
  end
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(30) }

  describe 'scope' do
    describe '#possible_attend_for' do
      subject { Lesson.possible_attend_for(user) }
      let(:school) { create(:school) }
      let(:lesson) { create(:lesson, school: school) }
      let(:tag_1) { create(:tag, school: school) }
      let(:tag_2) { create(:tag, school: school) }
      let(:tag_3) { create(:tag, school: school) }
      let(:user) { create(:user, school: school) }

      context 'タグを持っていないユーザー' do
        context 'タグを持っていない授業は含まれる' do
          it { is_expected.to include lesson }
        end
        context 'タグを持っている授業は含まれない' do
          let!(:lesson_tag) { create(:lesson_tag, lesson: lesson, tag: tag_1) }
          it { is_expected.not_to include lesson }
        end
      end
      context 'タグを1つ持つユーザー' do
        let!(:user_tag) { create(:user_tag, user: user, tag: tag_1) }

        context 'タグを持っていない授業は含まれる' do
          it { is_expected.to include lesson }
        end
        context '同じタグを持っている授業は含まれる' do
          let!(:lesson_tag) { create(:lesson_tag, lesson: lesson, tag: tag_1) }
          it { is_expected.to include lesson }
        end
        context '違うタグを持っている授業は含まれない' do
          let!(:lesson_tag) { create(:lesson_tag, lesson: lesson, tag: tag_2) }
          it { is_expected.not_to include lesson }
        end
        context '同じタグを含む複数のタグを持っている授業は含まれない' do
          let!(:lesson_tag_1) { create(:lesson_tag, lesson: lesson, tag: tag_1) }
          let!(:lesson_tag_2) { create(:lesson_tag, lesson: lesson, tag: tag_2) }
          it { is_expected.not_to include lesson }
        end
      end
      context 'タグを2つ持つユーザー' do
        let!(:user_tag_1) { create(:user_tag, user: user, tag: tag_1) }
        let!(:user_tag_2) { create(:user_tag, user: user, tag: tag_2) }

        context 'タグを持っていない授業は含まれる' do
          it { is_expected.to include lesson }
        end
        context '同じタグを1つ持っている授業は含まれる' do
          let!(:lesson_tag) { create(:lesson_tag, lesson: lesson, tag: tag_1) }
          it { is_expected.to include lesson }
        end
        context '違うタグを持っている授業は含まれない' do
          let!(:lesson_tag) { create(:lesson_tag, lesson: lesson, tag: tag_3) }
          it { is_expected.not_to include lesson }
        end
        context '2つの同じタグを持っている授業は含まれる' do
          let!(:lesson_tag_1) { create(:lesson_tag, lesson: lesson, tag: tag_1) }
          let!(:lesson_tag_2) { create(:lesson_tag, lesson: lesson, tag: tag_2) }
          it { is_expected.to include lesson }
        end
        context 'ユーザーの持つタグを含む3つのタグを持っている授業は含まれない' do
          let!(:lesson_tag_1) { create(:lesson_tag, lesson: lesson, tag: tag_1) }
          let!(:lesson_tag_2) { create(:lesson_tag, lesson: lesson, tag: tag_2) }
          let!(:lesson_tag_2) { create(:lesson_tag, lesson: lesson, tag: tag_3) }
          it { is_expected.not_to include lesson }
        end
      end
    end
  end

  describe '#checking_question_count' do
    subject { lesson.checking_question_count }

    let!(:lesson) { create(:lesson) }
    let!(:question_1) { create(:question, lesson: lesson) }
    let!(:question_2) { create(:question, lesson: lesson) }
    let!(:question_3) { create(:question) }
    let!(:question_status_1_not) do
      create(:question_status, :not_submitted, question: question_1)
    end
    let!(:question_status_1_checking) do
      create(:question_status, :checking, question: question_1)
    end
    let!(:question_status_2_checking) do
      create(:question_status, :checking, question: question_2)
    end
    context '元々2つチェック中がある' do
      it { is_expected.to eq 2 }
    end

    context '別のチェック中のものができると3つになる' do
      let!(:question_status_2_checking_2) do
        create(:question_status, :checking, question: question_2)
      end
      it { is_expected.to eq 3 }
    end

    context '別の講座の問題のチェック中のものができても2つ' do
      let!(:question_status_3_checking) do
        create(:question_status, :checking, question: question_3)
      end
      it { is_expected.to eq 2 }
    end
  end
end
