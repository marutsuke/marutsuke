# frozen_string_literal: true

module LineApiHelper

  def line_authorize_request_url(state)
    client_id = Rails.application.credentials.line_login[:channel_id]
    bot_prompt = 'aggressive'
    scope = 'profile'

    "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&bot_prompt=#{bot_prompt}&scope=#{scope}"
  end

  def redirect_uri
    if Rails.env.production?
      'https://marutsukeapp.com/line_api/new'
    elsif Rails.env.development?
      'http://localhost:3000/line_api/new'
    end
  end

end
