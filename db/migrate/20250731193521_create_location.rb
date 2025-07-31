class CreateLocation < ActiveRecord::Migration[6.1]
  def up
    create_table :locations do |t|
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code
      t.float :longitude
      t.float :latitude

      t.timestamps

      t.index [:city, :state, :country]
      t.index [:zip_code, :country]
      t.index [:longitude, :latitude]
    end
  end

  def down
    drop_table :locations
  end
end
