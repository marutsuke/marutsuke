require 'rails_helper'

RSpec.describe "Terms", type: :request do
  describe '/terms#index' do
    it 'ユーザーmypageを表示する' do
      get terms_path
      expect(response).to have_http_status(200)
    end
  end
end
