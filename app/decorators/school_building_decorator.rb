# frozen_string_literal: true

class SchoolBuildingDecorator < ApplicationDecorator
  delegate_all
  def auto_invite
    super ? '自動許可する' : '承認が必要'
  end

  def invite_code_availability
    super ? '有効' : '無効'
  end
end
