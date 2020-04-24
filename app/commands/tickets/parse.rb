# frozen_string_literal: true

module Tickets
  class Parse
    include SimpleService

    commands Tickets::Represent,
             Tickets::Validate
  end
end
