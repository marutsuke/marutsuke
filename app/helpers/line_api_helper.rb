# frozen_string_literal: true
require 'net/http'
require 'uri'

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
      'https://marutsukeapp.com/user_authentications/line_authentications/line_logged_in'
    elsif Rails.env.development?
      'http://localhost:3000/user_authentications/line_authentications/line_logged_in'
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

  def get_line_user_id(redirect_uri: ,code: )
    client_secret = Rails.application.credentials.line_login[:channel_secret]
    client_id = Rails.application.credentials.line_login[:channel_id]
    uri = URI.parse("https://api.line.me/oauth2/v2.1/token")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/x-www-form-urlencoded"
    request.set_form_data(
      grant_type: 'authorization_code',
      code: code,
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


end
