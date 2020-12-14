class LineApiController < UserBase

  def create
    return if current_user.user_authentication.provider == 'line'

    if current_user.line_state_save
      state = current_user.user_line_state_token
      redirect_to line_authorize_request_url(state: state, redirect_uri: link_line_account_redirect_uri)
    end
  end

  def new
    return if error_present?

    user_line_state_token = params[:state]
    friendship_status_changed = params[:friendship_status_changed] ==  'true'

    if current_user&.line_authenticated?(user_line_state_token)
      line_user_id = get_line_user_id(redirect_uri: link_line_account_redirect_uri, code: params[:code])
      if current_user.change_authenticatoin_email_to_line(line_user_id) && friendship_status_changed
        flash[:success] = 'LINE通知を設定しました！'
        redirect_to mypage_users_path
      else
        flash[:info] = 'すでに設定されていました'
        redirect_to mypage_users_path
      end
    else
      flash[:danger] = 'LINE通知の設定に失敗しました。'
      redirect_to mypage_users_path
    end
  end

  def send_message
    return unless current_user.line_user_id


    response = simple_line_message(to: current_user, text: 'テスト')
    flash[:success] = 'LINEメッセージを送ったはず'
    redirect_to mypage_users_path
  end


  private

  def error_present?
    if params[:error].present?
      flash[:danger] = 'LINE通知を拒否しました。'
      redirect_to mypage_users_path
      return true
    end
  end

end
