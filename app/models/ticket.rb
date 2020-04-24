class Ticket < ApplicationRecord
  has_one :excavator, dependent: :destroy
  accepts_nested_attributes_for :excavator

  enum request_type: { normal: 'Normal' }
end
