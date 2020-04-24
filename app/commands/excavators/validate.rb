# frozen_string_literal: true

module Excavators
  class Validate
    include SimpleService

    def call(attributes:)
      contract = Contract.new.call(attributes)
      if contract.success?
        success(attributes: contract.to_h)
      else
        failure(contract.errors.to_h)
      end
    end
  end

  class Contract < Dry::Validation::Contract
    schema do
      required(:company_name).filled(:string)
      required(:address).filled(:string)
      required(:crew_onsite).filled(:bool)
    end
  end
end
