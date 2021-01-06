require 'rails_helper'

RSpec.describe "AgreementConfirms", type: :request do
  describe '/agreement_confirms#index' do
    it 'ユーザーmypageを表示する' do
      get agreement_confirms_path
      expect(response).to have_http_status(200)
    end
  end
end
