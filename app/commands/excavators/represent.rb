# frozen_string_literal: true

module Excavators
  class Represent
    include SimpleService

    def call(json:)
      excavator = ExcavatorRepresenter.new(Excavator.new).from_json(json)
      success(attributes: excavator.attributes.symbolize_keys.except(:id, :created_at, :updated_at, :ticket_id))
    rescue MultiJson::ParseError
      failure('invalid JSON data')
    end
  end

  class ExcavatorRepresenter < Representable::Decorator
    include Representable::JSON

    nested :Excavator do
      property :company_name, as: :CompanyName
      property :address,
               as: :Address,
               parse_filter: ->(_fragment, options) { options[:doc].values_at('Address', 'City', 'State', 'Zip').join(', ') }
      property :crew_onsite, as: :CrewOnsite
    end
  end
end
