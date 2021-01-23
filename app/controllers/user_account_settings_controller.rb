class UserAccountSettingsController < UserBase
  skip_before_action :school_select_required

  def index
    #アカウント削除、クレジットカード登録、メール確認など
  end
end
