# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:lesson) }
  end

  describe 'question_status関連のスコープ' do
    let!(:question) { create(:question) }
    it { expect(Question.checking).not_to include(question) }
    it { expect(Question.will_submit_again).not_to include(question) }
    it { expect(Question.complete).not_to include(question) }
    it { expect(Question.any_user_unchecked).to include(question) }
    it { expect(Question.have_any_question_status_submitted).not_to include(question) }

    context 'chekingの問題' do
      let!(:question_status) do
        create(:question_status, status: :checking, question: question)
      end
      it { expect(Question.checking).to include(question) }
      it { expect(Question.have_any_question_status_submitted).to include(question) }
    end

    context 'will_submit_againの問題' do
      let!(:question_status) do
        create(:question_status, status: :will_submit_again, question: question)
      end
      it { expect(Question.will_submit_again).to include(question) }
      it { expect(Question.have_any_question_status_submitted).to include(question) }
    end

    context 'commentedの問題' do
      let!(:question_status) do
        create(:question_status, status: :complete, question: question)
      end
      it { expect(Question.complete).to include(question) }
      it { expect(Question.any_user_unchecked).not_to include(question) }
      it { expect(Question.have_any_question_status_submitted).to include(question) }
    end

    context 'completeの問題' do
      let!(:question_status) do
        create(:question_status, status: :complete, question: question)
      end
      it { expect(Question.complete).to include(question) }
      it { expect(Question.any_user_unchecked).not_to include(question) }
      it { expect(Question.have_any_question_status_submitted).to include(question) }
    end
  end
end
