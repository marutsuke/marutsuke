require 'rails_helper'

RSpec.describe "Teacher::Tops", type: :request do
  let!(:teacher) { create(:teacher) }
  before { teacher_log_in teacher }

  describe 'GET /teacher' do
    it '自分の所属の学校の情報編集にアクセスできる' do
      get teacher_path
      expect(response).to have_http_status(200)
    end
  end
end
