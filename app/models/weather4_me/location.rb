=begin
Columns:
  address - normalized address entered by user; could be used for searching this 1st b4 Geocoder
=end
class Weather4Me::Location < ApplicationRecord
  has_many :forecasts, class_name: 'Weather4Me::Forecast', foreign_key: 'location_id'

  def to_short_s
    [city, state].compact.join(', ')
  end

  def to_s
    s = to_short_s
    s << " #{zip_code}" if zip_code.present?
    s << ", #{country}" if country.present?
    s
  end
end
