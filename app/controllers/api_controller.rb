# frozen_string_literal: true

class ApiController < ActionController::API
  rescue_from StandardError, with: :server_error

  private

  def server_error(exception)
    Rails.logger.error(exception)
    render json: { error: 'Internal Server Error', status: '500' },
           status: :internal_server_error
  end

  def response_message
    { message: @result.value[:message], status: @result.value[:status] }
  end

  def response_status
    @result.value[:status]
  end
end
