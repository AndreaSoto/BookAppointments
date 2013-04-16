class QuoteItems < ActiveRecord::Migration
  def up
  	add_column :quotes, :h_feet, :integer
  	add_column :quotes, :h_inches, :integer
  	add_column :quotes, :l_feet, :integer
  	add_column :quotes, :l_inches, :integer
  	add_column :quotes, :w_feet, :integer
  	add_column :quotes, :w_inches, :integer
  	add_column :quotes, :ceiling, :integer
  	add_column :quotes, :insulated, :integer
  	add_column :quotes, :panel, :integer

  end

  def down
  	remove_column :quotes, :h_feet
  	remove_column :quotes, :h_inches
  	remove_column :quotes, :l_feet
  	remove_column :quotes, :l_inches
  	remove_column :quotes, :w_feet
  	remove_column :quotes, :w_inches
  	remove_column :quotes, :ceiling 
  	remove_column :quotes, :insulated
  	remove_column :quotes, :panel
  end
end
