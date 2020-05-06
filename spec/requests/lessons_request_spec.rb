# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LessonsController', type: :request do
  describe '/lessons#new' do
    it 'アクセスできる' do
      get lessons_path
      expect(response).to have_http_status(200)
    end
  end
end
