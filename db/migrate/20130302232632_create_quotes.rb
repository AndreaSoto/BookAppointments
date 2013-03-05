class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :hash
      t.string :name
      t.string :email
      t.string :cell

      t.timestamps
    end
  end
end
