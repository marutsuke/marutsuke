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
    describe '#to_check' do
      subject { Lesson.to_check }
      let!(:lesson) { create(:lesson) }
      let!(:question_1) { create(:question, lesson: lesson) }

      context '元々、授業は含まれない' do
        it { is_expected.not_to include lesson }
      end

      context 'チェック中の問題がある時に、含まれる' do
        let!(:question_status_checking) do
          create(:question_status, :checking, question: question_1)
        end
        it { is_expected.to include lesson }
      end
    end

    describe 'no_question' do
      subject { Lesson.no_question }
      let!(:lesson) { create(:lesson) }

      context '課題がない' do
        it { is_expected.to include lesson }
      end
      context '課題がある' do
        let!(:question) { create(:question, lesson: lesson) }
        it { is_expected.not_to include lesson }
      end
    end

    describe 'has_unpublish_question' do
      subject { Lesson.has_unpublish_question }
      let!(:lesson) { create(:lesson) }

      context '課題がない' do
        it { is_expected.not_to include lesson }
      end
      context '課題がある' do
        context '公開済みの課題のみ' do
          let!(:question) { create(:question, :published, lesson: lesson) }
          let!(:question_2) { create(:question, :published, lesson: lesson) }
          it { is_expected.not_to include lesson }
        end

        context '公開済みの課題と非公開の課題' do
          let!(:question) { create(:question, :published, lesson: lesson) }
          let!(:question_2) { create(:question, :unpublish, lesson: lesson) }
          it { is_expected.to include lesson }
        end
      end
    end
  end

  describe 'has_published_question' do
    subject { Lesson.has_published_question }
    let!(:lesson) { create(:lesson) }

    context '課題がない' do
      it { is_expected.not_to include lesson }
    end
    context '課題がある' do
      context '非公開の課題のみ' do
        let!(:question) { create(:question, :unpublish, lesson: lesson) }
        let!(:question_2) { create(:question, :unpublish, lesson: lesson) }
        it { is_expected.not_to include lesson }
      end

      context '公開済みの課題と非公開の課題' do
        let!(:question) { create(:question, :published, lesson: lesson) }
        let!(:question_2) { create(:question, :unpublish, lesson: lesson) }
        it { is_expected.to include lesson }
      end
    end
  end

  describe '#checking_count' do
    subject { lesson.checking_count }

    let!(:lesson) { create(:lesson) }
    let!(:question_1) { create(:question, lesson: lesson) }
    let!(:question_2) { create(:question, lesson: lesson) }
    let!(:question_3) { create(:question) }
    let!(:question_status_1_not) do
      create(:question_status, :will_do, question: question_1)
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

    context '別の授業の問題のチェック中のものができても2つ' do
      let!(:question_status_3_checking) do
        create(:question_status, :checking, question: question_3)
      end
      it { is_expected.to eq 2 }
    end
  end
end
