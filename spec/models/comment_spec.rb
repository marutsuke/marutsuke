# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:answer) }
    it { is_expected.to belong_to(:teacher) }
  end
  it { is_expected.to validate_length_of(:text).is_at_most(800) }
  it '問題の評価と、コメントの評価のカラムが同じ(check_formでエラーが起こりうる if false)' do
    expect(QuestionStatus.statuses).to eq (Comment.evaluations)
  end
end
