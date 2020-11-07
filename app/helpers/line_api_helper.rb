# frozen_string_literal: true

module LineApiHelper

  def line_authorize_request_url(state: , redirect_uri:)
    client_id = Rails.application.credentials.line_login[:channel_id]
    bot_prompt = 'aggressive'
    scope = 'profile'

    "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&bot_prompt=#{bot_prompt}&scope=#{scope}"
  end

  def link_line_account_redirect_uri
    if Rails.env.production?
      'https://marutsukeapp.com/line_api/new'
    elsif Rails.env.development?
      'http://localhost:3000/line_api/new'
    end
  end

  def sign_up_redirect_uri
    if Rails.env.production?
      'https://marutsukeapp.com/line_api/line_sign_up_new'
    elsif Rails.env.development?
      'http://localhost:3000/line_api/line_sign_up_new'
    end
  end

  def simple_line_message(to:, text:)
    return if to.line_user_id.nil?

    message = {
      type: 'text',
      text: text
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.line_message[:channel_secret]

      config.channel_token = Rails.application.credentials.line_message[:channel_access_token]
    }
    client.push_message(to.line_user_id, message)
  end
end
