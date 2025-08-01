Geocoder.configure(
  lookup: :google,
  api_key: ENV['GOOGLE_MAPS_API_KEY'] || 'AIzaSyD8knMVPEx-nj2U7CnTbdwBQrP-tPbTwN0',
  use_https: true
)