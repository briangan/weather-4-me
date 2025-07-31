require "test_helper"

class Weather4Me::ForecastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather4_me_forecast = weather4_me_forecasts(:one)
  end

  test "should get index" do
    get weather4_me_forecasts_url
    assert_response :success
  end

  test "should get new" do
    get new_weather4_me_forecast_url
    assert_response :success
  end

  test "should create weather4_me_forecast" do
    assert_difference('Weather4Me::Forecast.count') do
      post weather4_me_forecasts_url, params: { weather4_me_forecast: { condition: @weather4_me_forecast.condition, current_temp: @weather4_me_forecast.current_temp, expires_at: @weather4_me_forecast.expires_at, forecast_time: @weather4_me_forecast.forecast_time, high_temp: @weather4_me_forecast.high_temp, location_id: @weather4_me_forecast.location_id, low_temp: @weather4_me_forecast.low_temp } }
    end

    assert_redirected_to weather4_me_forecast_url(Weather4Me::Forecast.last)
  end

  test "should show weather4_me_forecast" do
    get weather4_me_forecast_url(@weather4_me_forecast)
    assert_response :success
  end

  test "should get edit" do
    get edit_weather4_me_forecast_url(@weather4_me_forecast)
    assert_response :success
  end

  test "should update weather4_me_forecast" do
    patch weather4_me_forecast_url(@weather4_me_forecast), params: { weather4_me_forecast: { condition: @weather4_me_forecast.condition, current_temp: @weather4_me_forecast.current_temp, expires_at: @weather4_me_forecast.expires_at, forecast_time: @weather4_me_forecast.forecast_time, high_temp: @weather4_me_forecast.high_temp, location_id: @weather4_me_forecast.location_id, low_temp: @weather4_me_forecast.low_temp } }
    assert_redirected_to weather4_me_forecast_url(@weather4_me_forecast)
  end

  test "should destroy weather4_me_forecast" do
    assert_difference('Weather4Me::Forecast.count', -1) do
      delete weather4_me_forecast_url(@weather4_me_forecast)
    end

    assert_redirected_to weather4_me_forecasts_url
  end
end
