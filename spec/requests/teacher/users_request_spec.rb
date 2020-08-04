# frozen_string_literal: true

require 'rails_helper'

describe Teacher::UsersController, type: :request do
  let!(:teacher) { create(:teacher) }
  before { teacher_log_in teacher }



end
