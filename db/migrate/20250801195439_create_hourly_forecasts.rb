class CreateHourlyForecasts < ActiveRecord::Migration[6.1]
  def up
    create_table :hourly_forecasts do |t|
      t.integer :location_id, null: false
      t.datetime :time
      t.integer :temp
      t.string :condition

      t.timestamps

      t.index :location_id
      t.index [:location_id, :time]
    end
  end

  def down
    drop_table :hourly_forecasts
  end
end
