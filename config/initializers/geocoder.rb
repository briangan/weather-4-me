Geocoder.configure(
  lookup: :google,
  api_key:  Rails.application.credentials.dig(:apis, :google_maps) || ENV['GOOGLE_MAPS_API_KEY'],
  use_https: true
)