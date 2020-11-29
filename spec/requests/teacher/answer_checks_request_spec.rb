require 'rails_helper'

RSpec.describe "Teacher::AnswerChecks", type: :request do
  #  TODO: 後に削除する。2020/11/03
  #  answer_checkコントローラーは、commentsコントローラーに移動したので、不要に。削除したい。
  # チェック画面の仕様を検討したい。
  # Ajaxで
  # describe 'チェック画面に入る' do
  #   let(:teacher) { create(:teacher) }
  #   before { teacher_log_in(teacher) }

  #   it 'チェック画面を表示する' do
  #     get checking_teacher_lesson_answer_checks_path(lesson)
  #   end
  # end
end
