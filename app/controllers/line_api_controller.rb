class LineApiController < UserBase
  include LineApiHelper

  def create
    if current_user.line_state_save
      state = current_user.user_line_state_token
      redirect_to line_authorize_request_url(state)
    end
  end

  def new
    return if error_present?

    user_line_state_token = params[:state]
    if current_user&.line_authenticated?(user_line_state_token)
      # get_and_save_user_access_token 設定必須
      flash[:success] = 'LINE通知を設定しました！'
      redirect_to mypage_users_path
    else
      flash[:success] = 'LINE通知の設定に失敗しました。'
      redirect_to mypage_users_path
    end
  end

  private

  def error_present?
    if params[:error].present?
      flash[:danger] = 'LINE通知を拒否しました。'
      redirect_to mypage_users_path
      return true
    end
  end

  def get_and_save_user_access_token
    # アクセストークンwp
  end
end
