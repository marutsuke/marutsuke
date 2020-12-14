class NotificationPermissionController < UserBase

  def permit
    current_user.update(notification_permission: true)
    flash[:success] = "通知設定をしました！"
    redirect_to mypage_users_path
  end

  def cancel
    current_user.update(notification_permission: false)
    flash[:danger] = "通知設定を解除しました。"
    redirect_to mypage_users_path
  end
end
