# frozen_string_literal: true

module Tickets
  class Create
    include SimpleService

    def call(json:)
      ticket = Tickets::Parse.call(json: json)
      return failure(status: :bad_request, message: ticket.value) if ticket.failure?

      excavator = Excavators::Parse.call(json: json)
      return failure(status: :bad_request, message: excavator.value) if excavator.failure?

      result = Tickets::Persist.call(attributes: ticket.value[:attributes]
                                                 .merge(excavator_attributes: excavator.value[:attributes]))
      return failure(status: :bad_request, message: result.value) if result.failure?

      success(status: :created, message: result.value)
    end
  end
end
