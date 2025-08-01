# Reference: https://www.weatherapi.com/docs/
# Refer to db/weatherapi_forecast.yml for the expected data structure.
require 'httparty'

class Weather4Me::WeatherApiService < Weather4Me::ApiService

  BASE_URL = 'https://api.weatherapi.com/v1'

  # @location <Weather4Me::Location> or a string representing the location
  # @return <Array of Forecast>
  def self.forecast(location)
    response = HTTParty.get("#{BASE_URL}/forecast.json", query: {
      key: WEATHER_API_KEY,
      q: location.to_s,
      days: 3
    })
    if response.success?
      j = JSON.parse(response.body)
      list = parse_forecast_data(j, location) do |location|
        yield location if block_given?
      end

      list

    else
      raise "Error fetching weather data: #{j.dig('error')}"
    end
  end

  # WeatherAPI doesn't have max & min temps in 'current' hash value; instead it's in 'forecast' hash.
  # @json <Hash of JSON response>
  # @location <Weather4Me::Location> for associating the location w/ the forecast
  # @yield <Location> allows access to matching location; perhaps making change to it like setting zip_code
  # @return <Array of Forecast>
  def self.parse_forecast_data(json, location)
    # loc_h = json['location']

    list = []
    day_forecast = Weather4Me::Forecast.new(
      location_id: location&.id,
      current_temp: json.dig('current', 'temp_f'),
      forecast_time: Time.now # maybe API could be delayed 
    )
    
    if ( forecast_list = json.dig('forecast', 'forecastday') )
      
      list = []
      forecast_list.each do |forecastday|
        day_forecast.attributes = { high_temp: forecastday.dig('day', 'maxtemp_f'),
          low_temp: forecastday.dig('day', 'mintemp_f'),
          condition: forecastday.dig('day', 'condition', 'text')&.strip
        }
        
        # Here can add hourly forecasts if needed
        # 
      end # each forecastday
    end

    day_forecast.save
    list << day_forecast

    list
  end
end


