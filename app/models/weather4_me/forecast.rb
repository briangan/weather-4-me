=begin
Saved result of current moment's weather forecast from API service.
Columns:
  location_id - foreign key to Weather4Me::Location
  current_temp - current temperature at the moment of API request in Fahrenheit
  low_temp - low temperature for the day in Fahrenheit
  high_temp - high temperature for the day in Fahrenheit                        
  condition - extra text description of the weather condition, e.g. "Sunny", "Cloudy", etc.                      
  forecast_time - time when the forecast was requested, used to determine if the forecast is expired
  created_at - timestamp of when the record was created
  updated_at - timestamp of when the record was last updated
=end
class Weather4Me::Forecast < ApplicationRecord
  self.table_name = "forecasts"

  EXPIRATION_TIME = 30.minutes

  belongs_to :location, class_name: 'Weather4Me::Location', foreign_key: 'location_id'

  scope :not_expired, -> { where('forecast_time > ?', Time.now - EXPIRATION_TIME) }

  validates_presence_of :location_id, :current_temp, :forecast_time
end
