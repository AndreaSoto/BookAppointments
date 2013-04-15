class ApptDateTime < ActiveRecord::Migration
  def up
  	add_column :appointments, :day, :string
  	add_column :appointments, :time, :string
  end

  def down
  	remove_column :appointments, :day
  	remove_column :appointments, :time
  end
end
