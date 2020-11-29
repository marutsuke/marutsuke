# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionStatus, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:question) }
    it { is_expected.to validate_presence_of(:status) }
  end
  describe 'scope' do
    describe 'order_by_question_order_at' do
      let(:lesson1) { create(:lesson) }
      let(:lesson2) { create(:lesson) }
      let!(:question1_1) { create(:question, lesson: lesson1, display_order: 1) }
      let!(:question1_2) { create(:question, lesson: lesson1, display_order: 2) }
      let!(:question1_3) { create(:question, lesson: lesson1, display_order: 3) }
      let(:question2_1) { create(:question, lesson: lesson2, display_order: 1) }
      context "lesson内の問題のstatusは" do
        let!(:question_status) { create(:question_status, question: question1_1) }
        it '含む' do
          expect(
            QuestionStatus.order_by_question_order_at(lesson1)
          ).to include(question_status)
        end
      end
      context "lesson外の問題のstatusは" do
        let!(:question_status) { create(:question_status, question: question2_1) }
        it '含まない' do
          expect(
            QuestionStatus.order_by_question_order_at(lesson1)
          ).not_to include(question_status)
        end
      end
      context "lesson外の問題のstatusは" do
        let!(:question_status) { create(:question_status, question: question2_1) }
        it '含まない' do
          expect(
            QuestionStatus.order_by_question_order_at(lesson1)
          ).not_to include(question_status)
        end
      end
      context "display_orderが違う問題のstatus" do
        let!(:question_status1) { create(:question_status, question: question1_1) }
        let!(:question_status2) { create(:question_status, question: question1_2) }
        let!(:question_status3) { create(:question_status, question: question1_3) }

        it '問題の順番通り' do
          expect(
            QuestionStatus.order_by_question_order_at(lesson1).first).to eq(question_status1)
          expect(
            QuestionStatus.order_by_question_order_at(lesson1).last).to eq(question_status3)
        end
      end
      context "display_order問題変更して" do
        let!(:question_status1) { create(:question_status, question: question1_3) }
        let!(:question_status2) { create(:question_status, question: question1_2) }

        it '問題の順番変更した通り' do
          expect(
            QuestionStatus.order_by_question_order_at(lesson1)
          .first).to eq(question_status2)
          expect(
            QuestionStatus.order_by_question_order_at(lesson1)
          .last).to eq(question_status1)
        end
      end
    end
  end

  describe '#課題チェック関連' do
    let!(:question){ create(:question) }
    let!(:user_1){ create(:user, id: 1) }
    let!(:user_2){ create(:user, id: 2) }
    let!(:user_3){ create(:user, id: 3) }
    let!(:user_4){ create(:user, id: 4) }
    let!(:user_5){ create(:user, id: 5) }
    let!(:user_6){ create(:user, id: 6) }
    let!(:user_7){ create(:user, id: 7) }
    let!(:question_status_will_do_1){ create(:question_status, :will_do, question: question, user: user_1) }
    let!(:question_status_will_do_2){ create(:question_status, :will_do, question: question, user: user_2) }
    let!(:question_status_commented_1){ create(:question_status, :commented, question: question, user: user_3) }
    let!(:question_status_commented_2){ create(:question_status, :commented, question: question, user: user_4) }
    let!(:question_status_checking_1){ create(:question_status, :checking, question: question, user: user_5) }
    let!(:question_status_checking_2){ create(:question_status, :checking, question: question, user: user_6) }
    let!(:question_status_checking_other_question){ create(:question_status, :checking, user: user_7) }

    describe '#next_question_status_submitted' do
      it 'statusがwill_doの時' do
        expect(question_status_will_do_1.next_question_status_submitted).to eq question_status_commented_1
        expect(question_status_will_do_2.next_question_status_submitted).to eq question_status_commented_1
      end
      it 'statusがcommentedの時' do
        expect(question_status_commented_1.next_question_status_submitted).to eq question_status_commented_2
      end
      it '次がない時がcommentedの時' do
        expect(question_status_checking_2.next_question_status_submitted).to eq nil
      end
    end
    describe '#prev_question_status_submitted' do
      it '前がない時' do
        expect(question_status_will_do_1.prev_question_status_submitted).to eq nil
        expect(question_status_will_do_2.prev_question_status_submitted).to eq nil
        expect(question_status_commented_1.prev_question_status_submitted).to eq nil
      end
      it 'statusがcommentedの時' do
        expect(question_status_commented_2.prev_question_status_submitted).to eq question_status_commented_1
      end
    end
    describe '#next_question_status_to_check' do
      it 'statusがwill_doの時' do
        expect(question_status_will_do_1.next_question_status_to_check).to eq question_status_checking_1
      end
      it 'statusがcommentedの時' do
        expect(question_status_commented_1.next_question_status_to_check).to eq question_status_checking_1
      end
      it '次がない時がcommentedの時' do
        expect(question_status_checking_2.next_question_status_to_check).to eq nil
      end
    end
    describe '#prev_question_status_to_check' do
      it 'statusがwill_doの時' do
        expect(question_status_will_do_1.prev_question_status_to_check).to eq nil
        expect(question_status_commented_1.prev_question_status_to_check).to eq nil
        expect(question_status_checking_1.prev_question_status_to_check).to eq nil
      end
      it '次がない時がcommentedの時' do
        expect(question_status_checking_2.prev_question_status_to_check).to eq question_status_checking_1
      end
    end

  end

end
