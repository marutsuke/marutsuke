# frozen_string_literal: true

module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :rescue500
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private

  def rescue404(_e)
    render 'errors/not_found', status: 404
  end

  def rescue500(_e)
    render 'errors/internal_server_error', status: 500
  end
end