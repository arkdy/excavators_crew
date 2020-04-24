# frozen_string_literal: true

module Tickets
  class Represent
    include SimpleService

    def call(json:)
      ticket = TicketRepresenter.new(Ticket.new).from_json(json)
      success(attributes: ticket.attributes.symbolize_keys.except(:id, :created_at, :updated_at))
    rescue MultiJson::ParseError
      failure('invalid JSON data')
    end
  end

  class TicketRepresenter < Representable::Decorator
    include Representable::JSON

    property :request_number, as: :RequestNumber
    property :sequence_number, as: :SequenceNumber
    property :request_type, as: :RequestType
    nested :DateTimes do
      property :response_due_at, as: :ResponseDueDateTime
    end
    nested :ServiceArea do
      nested :PrimaryServiceAreaCode do
        property :primary_service_area_code, as: :SACode
      end
      nested :AdditionalServiceAreaCodes do
        property :additional_service_area_codes, as: :SACode
      end
    end
    nested :ExcavationInfo do
      nested :DigsiteInfo do
        property :geo_polygon,
                 as: :WellKnownText,
                 parse_filter: lambda { |fragment, _options|
                                 fragment.sub('POLYGON((', '')
                                   .sub('))', '')
                                   .split(',')
                                   .map do |x|
                                   x.split(' ')
                                     .map(&:to_f)
                                 end
                               }
      end
    end
  end
end
