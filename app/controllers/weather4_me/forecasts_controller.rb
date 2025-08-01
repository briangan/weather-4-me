# Handler for weather forecast requests
class Weather4Me::ForecastsController < ApplicationController
  before_action :set_forecast, only: %i[ show ]
  before_action :find_location, only: %i[index]

  # GET /forecasts or /forecasts.json
  # params
  #   :q - query for the location, can be ZIP code, city name, or full address.  If empty, no search is performed.
  def index
    if @location
      # Search by location or query parameter
      @forecasts = @location.forecasts.not_expired.order('forecast_time asc')
      if @forecasts.empty?
        @forecasts = Weather4Me::WeatherApiService.forecast(@location)
      else
        @is_cached = true
      end
    else
      @forecasts = []
    end

    # Distinct locations for the dropdown
    @recent_locations = Weather4Me::Location.order('id desc').limit(10)

    respond_to do |format|
      format.html
      format.json { render json: @forecasts }
    end
  end

  # GET /forecasts/1 or /forecasts/1.json
  # Print out details of specified Forecast by ID
  def show
    respond_to do |format|
      format.html
      format.json { render json: @forecast }
    end
  end


  private
    # Before action to set the forecast instance variable w/ params[:id]
    def set_forecast
      @forecast = Weather4Me::Forecast.find(params[:id])
    end

    # Depends on params[:q] being the query for the location via Geocoder.
    def find_location
      location_s = params[:q]&.strip
      if location_s.present?
        @location = Weather4Me::Location.find_for_location_string(location_s)

        if @location.nil?
          flash[:warning] = t('location.not_found')
        else
          @location.update(address: location_s.strip) if @location.address.blank?
        end
      end
    end

    # Only allow a list of trusted parameters through.  Mainly for saving Forecast record.  Not used now.
    def forecast_params
      params.require(:forecast).permit(:location_id, :current_temp, :low_temp, :high_temp, :condition, :forecast_time)
    end
end
