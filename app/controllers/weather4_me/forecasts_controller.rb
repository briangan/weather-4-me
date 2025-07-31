class Weather4Me::ForecastsController < ApplicationController
  before_action :set_weather4_me_forecast, only: %i[ show edit update destroy ]

  # GET /weather4_me/forecasts or /weather4_me/forecasts.json
  def index
    @weather4_me_forecasts = Weather4Me::Forecast.all
  end

  # GET /weather4_me/forecasts/1 or /weather4_me/forecasts/1.json
  def show
  end

  # GET /weather4_me/forecasts/new
  def new
    @weather4_me_forecast = Weather4Me::Forecast.new
  end

  # GET /weather4_me/forecasts/1/edit
  def edit
  end

  # POST /weather4_me/forecasts or /weather4_me/forecasts.json
  def create
    @weather4_me_forecast = Weather4Me::Forecast.new(weather4_me_forecast_params)

    respond_to do |format|
      if @weather4_me_forecast.save
        format.html { redirect_to @weather4_me_forecast, notice: "Forecast was successfully created." }
        format.json { render :show, status: :created, location: @weather4_me_forecast }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @weather4_me_forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather4_me/forecasts/1 or /weather4_me/forecasts/1.json
  def update
    respond_to do |format|
      if @weather4_me_forecast.update(weather4_me_forecast_params)
        format.html { redirect_to @weather4_me_forecast, notice: "Forecast was successfully updated." }
        format.json { render :show, status: :ok, location: @weather4_me_forecast }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @weather4_me_forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather4_me/forecasts/1 or /weather4_me/forecasts/1.json
  def destroy
    @weather4_me_forecast.destroy

    respond_to do |format|
      format.html { redirect_to weather4_me_forecasts_path, status: :see_other, notice: "Forecast was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather4_me_forecast
      @weather4_me_forecast = Weather4Me::Forecast.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def weather4_me_forecast_params
      params.require(:weather4_me_forecast).permit(:location_id, :current_temp, :low_temp, :high_temp, :condition, :forecast_time)
    end
end
