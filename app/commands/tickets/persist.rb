# frozen_string_literal: true

module Tickets
  class Persist
    include SimpleService

    def call(attributes:)
      model = Ticket.create(attributes)
      if model.save
        success(ticket_id: model.id)
      else
        failure(model.errors.full_messages)
      end
    end
  end
end
