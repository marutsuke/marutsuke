require 'net/http'
require 'uri'

class LineApiController < UserBase

  def create
    if current_user.line_state_save
      state = current_user.user_line_state_token
      redirect_to line_authorize_request_url(state)
    end
  end

  def new
    return if error_present?

    user_line_state_token = params[:state]
    friendship_status_changed = params[:friendship_status_changed] ==  'true'

    if current_user&.line_authenticated?(user_line_state_token)
      if get_and_save_line_user_id && friendship_status_changed
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


    message = {
      type: 'text',
      text: 'hello world from line'
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.line_message[:channel_secret]

      config.channel_token = Rails.application.credentials.line_message[:channel_access_token]
    }
    response = client.push_message(current_user.line_user_id, message)
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

  def get_and_save_line_user_id
    client_secret = Rails.application.credentials.line_login[:channel_secret]
    client_id = Rails.application.credentials.line_login[:channel_id]
    uri = URI.parse("https://api.line.me/oauth2/v2.1/token")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/x-www-form-urlencoded"
    request.set_form_data(
      grant_type: 'authorization_code',
      code: params[:code],
      redirect_uri:redirect_uri,
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

    save_line_user_id(access_token)
  end

  def save_line_user_id(access_token)
    client_secret = Rails.application.credentials.line_login[:channel_secret]

    uri = URI.parse("https://api.line.me/v2/profile")
    http = Faraday.new(url: "#{uri.scheme}://#{uri.host}")
    response = http.get do |req|
      req.url uri.path
      req.headers['Authorization'] = "Bearer #{access_token}"
    end
    line_user_id = JSON.parse(response.body)["userId"]
    current_user.update(line_user_id: line_user_id)
  end

  def get_user_id_redirect_url
    if Rails.env.production?
      'https://marutsukeapp.com/users/mypage'
    elsif Rails.env.development?
      'http://localhost:3000/users/mypage'
    end
  end
end
