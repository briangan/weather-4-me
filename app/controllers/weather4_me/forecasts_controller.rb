class Weather4Me::ForecastsController < ApplicationController
  before_action :set_forecast, only: %i[ show ]
  before_action :find_location, only: %i[index]

  # GET /forecasts or /forecasts.json
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
  end

  # GET /forecasts/1 or /forecasts/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forecast
      @forecast = Weather4Me::Forecast.find(params[:id])
    end

    # Depends on params[:q] being the query for the location via Geocoder.
    # If the address has enough detail down to street level, it will try to find the ZIP code.
    # If it cannot find a ZIP code, it will try to find the zip by latitude and longitude.
    def find_location
      location_s = params[:q]&.strip
      if location_s.present?
        # Maybe typing exact address or zip code, here can search in DB and save Geocoder request.
        # Location.where("address LIKE ? OR zip_code=:", "%#{params[:q]}%", params[:q]).first
        result = Geocoder.search(params[:q]).first
        zip = result&.postal_code
        if zip.blank? # position not precise enough
          mresult = Geocoder.search("#{result.latitude}, #{result.longitude}")
          result = mresult.find{|r| r.postal_code.present? }
          zip = result&.postal_code
        end
        
        if zip.present?
          @location = Weather4Me::Location.find_or_create_by(zip_code: zip) do |loc|
            loc.city = result&.city
            loc.state = result&.state
            loc.country = result&.country
            loc.latitude = result&.latitude
            loc.longitude = result&.longitude
          end
        else
          @location = nil
        end
      end

      unless @location
        flash[:alert] = 'Cannot find a valid location for this.'
        redirect_to weather4_me_forecasts_path
      end
    end

    # Only allow a list of trusted parameters through.
    def forecast_params
      params.require(:forecast).permit(:location_id, :current_temp, :low_temp, :high_temp, :condition, :forecast_time)
    end
end
