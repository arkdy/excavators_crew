# frozen_string_literal: true

module Excavators
  class Parse
    include SimpleService

    commands Excavators::Represent,
             Excavators::Validate
  end
end
