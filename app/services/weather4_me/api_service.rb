# Abstract service class for weather API interactions.
# This should be subclassed for specific API implementations such 
# as WeatherAPI
class Weather4Me::ApiService

  # Maybe this can dynamically choose the right API service subclass out of the multiple.
  # @location <Weather4Me::Location> or a string representing the location
  # @return <Array of Forecast>
  def self.forecast(location)
    []
  end
end

