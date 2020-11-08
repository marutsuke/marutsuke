require 'net/http'
require 'uri'

class LineApiController < UserBase
  before_action :user_log_out_required, only: %i[sign_up_page_by_line sign_up_by_line ]
  skip_before_action :user_login_required, :school_select_required, only: %i[sign_up_page_by_line sign_up_by_line line_sign_up_new line_sign_up_new]

  def create
    return if current_user.line_user_id.present?

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
      line_user_id = get_line_user_id(redirect_uri: link_line_account_redirect_uri)
      if current_user.update(line_user_id: line_user_id) && friendship_status_changed
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

  def sign_up_page_by_line
  end

  def sign_up_by_line
    @user_authentication = UserAuthentication.new(provider: 'line')
    if @user_authentication.save
        user_authentication_login(@user_authentication)
      @user_authentication.line_state_save
      state = @user_authentication.line_state_token
      redirect_to line_authorize_request_url(state: state, redirect_uri: sign_up_redirect_uri)
    else
      render :sign_up_page_by_line
    end
  end

  # line_idが登録済みかどうか検証する場所
  def line_sign_up_new
    return if sign_up_fail?

    if current_user_authentication.line_authenticated?(params[:state])
      line_user_id = get_line_user_id(redirect_uri: sign_up_redirect_uri)
      old_user_authentication_login(line_user_id)
      if user = current_user_authentication&.user
        flash[:info] = 'ログインしました。'
        user_log_in_without_school(user)
        redirect_to root_path
      else
        @user = User.new(name: '')
        if current_user_authentication.uid.present?
          flash[:info] = 'プロフィールを入力してね'
          redirect_to new_line_form_users_path
        else
          current_user_authentication.update(uid: line_user_id)
          flash[:success] = 'LINE登録に成功しました！ようこそ！プロフィールを入力してね'
          redirect_to new_line_form_users_path
        end
      end
    else
      flash[:danger] = 'LINE通知の設定に失敗しました。'
      redirect_to line_api_sign_up_by_line_path
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

  def sign_up_fail?
    if params[:error].present?
      flash[:danger] = 'LINE通知を拒否しました。'
      redirect_to sign_up_page_by_line_line_api_index_path
      return true
    end
  end

  def old_user_authentication_login(line_user_id)
    if old_user_authentication = UserAuthentication.find_by(uid: line_user_id, provider: 'line')
      user_authentication_login(old_user_authentication)
    end
  end

  def get_line_user_id(redirect_uri:)
    client_secret = Rails.application.credentials.line_login[:channel_secret]
    client_id = Rails.application.credentials.line_login[:channel_id]
    uri = URI.parse("https://api.line.me/oauth2/v2.1/token")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/x-www-form-urlencoded"
    request.set_form_data(
      grant_type: 'authorization_code',
      code: params[:code],
      redirect_uri: redirect_uri,
      client_id: client_id,
      client_secret: client_secret,
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    access_token = JSON.parse(response.body)["access_token"]

    line_user_id(access_token)
  end

  def line_user_id(access_token)
    client_secret = Rails.application.credentials.line_login[:channel_secret]

    uri = URI.parse("https://api.line.me/v2/profile")
    http = Faraday.new(url: "#{uri.scheme}://#{uri.host}")
    response = http.get do |req|
      req.url uri.path
      req.headers['Authorization'] = "Bearer #{access_token}"
    end
    line_user_id = JSON.parse(response.body)["userId"]
  end

  def get_user_id_redirect_url
    if Rails.env.production?
      'https://marutsukeapp.com/users/mypage'
    elsif Rails.env.development?
      'http://localhost:3000/users/mypage'
    end
  end

  def user_params
    params.require(:user).permit(:name, :name_kana, :birth_day, :school_grade, :email)
  end
end
