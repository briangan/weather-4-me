=begin
Saved result of hourly weather forecast from API service.  Not every API service provides hourly forecast, so this is optional.
Columns:
  location_id - foreign key to Weather4Me::Location
  time - time of the temperature                                                         
  temp - temperature at the given time in Fahrenheit                                                         
  condition - extra text description of the weather condition, e.g. "Sunny", "Cloudy", etc.
=end
class Weather4Me::HourlyForecast < ApplicationRecord
  self.table_name = 'hourly_forecasts'

  belongs_to :location, class_name: 'Weather4Me::Location'

  validates_presence_of :location_id, :time, :temp

end