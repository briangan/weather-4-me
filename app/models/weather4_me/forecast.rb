##
# Saved result of current moment's weather forecast from API service.
class Weather4Me::Forecast < ApplicationRecord
  EXPIRATION_TIME = 30.minutes
end
