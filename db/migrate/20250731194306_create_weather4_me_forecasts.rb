class CreateWeather4MeForecasts < ActiveRecord::Migration[6.1]
  def up
    create_table :forecasts do |t|
      t.integer :location_id
      t.integer :current_temp
      t.integer :low_temp
      t.integer :high_temp
      t.string :condition
      t.datetime :forecast_time

      t.timestamps

      t.index :location_id
      t.index [:location_id, :forecast_time]
    end
  end

  def down
    drop_table :forecasts
  end
end
