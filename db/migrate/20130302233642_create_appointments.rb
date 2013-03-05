class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :quote_id
      t.datetime :date
      t.text :location

      t.timestamps
    end
  end
end
