# frozen_string_literal: true

module Tickets
  class Validate
    include SimpleService

    def call(attributes:)
      contract = Tickets::Contract.new.call(attributes)
      if contract.success?
        success(attributes: contract.to_h)
      else
        failure(contract.errors.to_h)
      end
    end
  end

  class Contract < Dry::Validation::Contract
    schema do
      required(:request_number).filled(:string)
      required(:sequence_number).filled(:string)
      required(:request_type).filled(:string)
      required(:response_due_at).filled(:time)
      required(:primary_service_area_code).filled(:string)
      required(:additional_service_area_codes).array(:string)
      required(:geo_polygon).filled(:string)
    end
  end
end
