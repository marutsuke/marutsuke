# frozen_string_literal: true

class UserTag < ApplicationRecord
  belongs_to :tag
  belongs_to :user
end
