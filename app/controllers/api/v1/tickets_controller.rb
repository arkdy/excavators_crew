# frozen_string_literal: true

module Api
  module V1
    class TicketsController < ApiController
      def create
        @result = Tickets::Create.call(json: request.body.read)
        render json: response_message, status: response_status
      end
    end
  end
end
