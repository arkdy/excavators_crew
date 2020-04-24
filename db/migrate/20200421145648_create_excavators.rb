class CreateExcavators < ActiveRecord::Migration[6.0]
  def change
    create_table :excavators do |t|
      t.references :ticket, foreign_key: true
      t.string :company_name
      t.string :address
      t.boolean :crew_onsite, default: false

      t.timestamps
    end
  end
end
