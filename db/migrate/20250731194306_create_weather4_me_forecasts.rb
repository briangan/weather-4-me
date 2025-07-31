class CreateWeather4MeForecasts < ActiveRecord::Migration[6.1]
  def change
    create_table :weather4_me_forecasts do |t|
      t.integer :location_id
      t.integer :current_temp
      t.integer :low_temp
      t.integer :high_temp
      t.string :condition
      t.datetime :forecast_time
      t.datetime :expires_at

      t.timestamps
    end
  end
end
