json.extract! weather4_me_forecast, :id, :location_id, :current_temp, :low_temp, :high_temp, :condition, :forecast_time, :expires_at, :created_at, :updated_at
json.url weather4_me_forecast_url(weather4_me_forecast, format: :json)
