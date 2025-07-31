require "application_system_test_case"

class Weather4Me::ForecastsTest < ApplicationSystemTestCase
  setup do
    @weather4_me_forecast = weather4_me_forecasts(:one)
  end

  test "visiting the index" do
    visit weather4_me_forecasts_url
    assert_selector "h1", text: "Weather4 Me/Forecasts"
  end

  test "creating a Forecast" do
    visit weather4_me_forecasts_url
    click_on "New Weather4 Me/Forecast"

    fill_in "Condition", with: @weather4_me_forecast.condition
    fill_in "Current temp", with: @weather4_me_forecast.current_temp
    fill_in "Forecast time", with: @weather4_me_forecast.forecast_time
    fill_in "High temp", with: @weather4_me_forecast.high_temp
    fill_in "Location", with: @weather4_me_forecast.location_id
    fill_in "Low temp", with: @weather4_me_forecast.low_temp
    click_on "Create Forecast"

    assert_text "Forecast was successfully created"
    click_on "Back"
  end

  test "updating a Forecast" do
    visit weather4_me_forecasts_url
    click_on "Edit", match: :first

    fill_in "Condition", with: @weather4_me_forecast.condition
    fill_in "Current temp", with: @weather4_me_forecast.current_temp
    fill_in "Forecast time", with: @weather4_me_forecast.forecast_time
    fill_in "High temp", with: @weather4_me_forecast.high_temp
    fill_in "Location", with: @weather4_me_forecast.location_id
    fill_in "Low temp", with: @weather4_me_forecast.low_temp
    click_on "Update Forecast"

    assert_text "Forecast was successfully updated"
    click_on "Back"
  end

  test "destroying a Forecast" do
    visit weather4_me_forecasts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Forecast was successfully destroyed"
  end
end
