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

        it '問題の順番通り' do
          expect(
            QuestionStatus.order_by_question_order_at(lesson1)
          .first).to eq(question_status1)
          expect(
            QuestionStatus.order_by_question_order_at(lesson1)
          .last).to eq(question_status2)
        end

        context '問題の順番を変更' do
          before do
            question1_1.update(display_order: 2)
            question1_2.update(display_order: 1)
          end
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
  end

end
