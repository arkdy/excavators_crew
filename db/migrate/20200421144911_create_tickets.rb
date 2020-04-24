class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :request_number
      t.string :sequence_number
      t.string :request_type
      t.datetime :response_due_at
      t.string :primary_service_area_code
      t.string :additional_service_area_codes, array: true, default: []
      t.text :geo_polygon

      t.timestamps
    end
  end
end
