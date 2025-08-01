require "test_helper"

class ForecastsIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @location = Weather4Me::Location.create!(
      city: "San Francisco",
      state: "CA",
      country: "US",
      zip_code: "94103",
      latitude: 37.7749,
      longitude: -122.4194
    )
    @forecast = Weather4Me::Forecast.create!(
      location: @location,
      current_temp: 65,
      low_temp: 55,
      high_temp: 70,
      condition: "Sunny",
      forecast_time: Time.now
    )
    @same_address_h = {
      zip_code: "02169",
      variants:
        ['Quincy, MA', 'Quincy, MA, United States',
          '1 Dimmock St, Quincy, MA 02169', '1 Dimmock St, Quincy, MA 02169, United States' ]
      }
  end

  test "should get index showing cached" do
    get weather4_me_forecasts_path(q: "San Francisco, CA")
    # Check if body has word "* Cached *" indicating cached forecasts
    assert_select "body", /Cached/i
    assert_select "body", /Sunny/
  end

  test "should show forecast" do
    get weather4_me_forecast_path(@forecast)
    assert_select "body", /Sunny/
  end

  test "Invalid location" do
    get weather4_me_forecasts_path(q: "Invalid Location")
    assert_select "body", text: I18n.t('location.not_found')
  end

  test "Fresh real time API call" do
    zip_code = @same_address_h[:zip_code]
    Weather4Me::Location.where(zip_code: zip_code).destroy_all

    loc_forecast = nil
    @same_address_h[:variants].each_with_index do |address, index|
      get weather4_me_forecasts_path(q: address)
      if index == 0
        # check Location
        loc = Weather4Me::Location.where(zip_code: zip_code).first
        assert_not_nil(loc, "Location should be created for address")
        assert_equal(loc.city, "Quincy")
        assert( %w(MA Massachusetts).include?(loc.state), "State should be MA")

        # check Forecast
        loc_forecast ||= Weather4Me::Forecast.where(location_id: loc.id).first
        assert_not_nil(loc_forecast, "Forecast should be created for location")
        assert_nil(response.body.match(/\bCached\b/i), 'First request should not be cached')

      else
        assert(response.body.match(/\bCached\b/i), 'Subsequent request be cached')
        if loc_forecast
          validate_table_values_of_forecast(response, loc_forecast)
        end
      end
    end
  end

  private

  def validate_table_values_of_forecast(response, forecast)
    assert_select "td[data-column=current_temp]", text: forecast.current_temp.to_s
    assert_select "td[data-column=low_temp]", text: forecast.low_temp.to_s
    assert_select "td[data-column=high_temp]", text: forecast.high_temp.to_s
    assert_select "td[data-column=condition]", text: forecast.condition
    assert_select "td[data-column=forecast_time]", text: forecast.forecast_time.strftime('%I:%M %P')
  end
end