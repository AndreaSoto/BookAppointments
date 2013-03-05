class ModifyHasAttribute < ActiveRecord::Migration
  def change
    add_column :quotes, :quote_number, :string
    remove_column :quotes, :hash
  end
end
