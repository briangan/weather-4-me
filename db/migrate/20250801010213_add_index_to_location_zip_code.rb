class AddIndexToLocationZipCode < ActiveRecord::Migration[6.1]
  def up
    add_column :locations, :address, :string, limit: 200, null: true
    add_index :locations, :zip_code
  end

  def down
    remove_column :locations, :address
    remove_index :locations, :zip_code
  end
end
