##
# Saved result of current moment's weather forecast from API service.
class Weather4Me::Forecast < ApplicationRecord
  self.table_name = "forecasts"

  EXPIRATION_TIME = 30.minutes

  belongs_to :location, class_name: 'Weather4Me::Location', foreign_key: 'location_id'

  scope :not_expired, -> { where('forecast_time > ?', Time.now - EXPIRATION_TIME) }

  validates_presence_of :location_id, :current_temp, :forecast_time
end
