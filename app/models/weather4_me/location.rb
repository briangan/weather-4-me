=begin
Columns:
  city - standardized city name from Geocoder or API service
  state - standardized state name from Geocoder or API service                       
  country - standardized country name from Geocoder or API service                     
  zip_code - standardized postal code for the location, used saved Forecast records specific to this zip code
  longitude - longitude of the location, captured from Geocoder or API service
  latitude - latitude of the location, captured from Geocoder or API service     
  created_at - timestamp of when the record was created
  updated_at - timestamp of when the record was last updated                            
  address - user entered address to search for location; usable for repeated same address search to get same cached location.  Currently not used yet.
=end
class Weather4Me::Location < ApplicationRecord
  has_many :forecasts, class_name: 'Weather4Me::Forecast', foreign_key: 'location_id'

  before_save :normalize_attributes

  def to_short_s
    s = [city, state].compact.join(', ')
    s << " #{zip_code}" if zip_code.present?
    s
  end

  def to_s
    s = to_short_s
    s << ", #{country}" if country.present? && !is_country_us?
    s
  end

  def is_country_us?
    ['usa', 'united states', 'united states of america'].include?(country&.downcase)
  end

  ############################
  # Class Methods
  # 

  # Use Geocoder to find the standardized location by address.
  # @location_s <String> representing the location, can be ZIP code, city name, or full address.
  # If the address has enough detail down to street level, it will try to find the ZIP code.
  # If it cannot find a ZIP code, it will try to find the zip by latitude and longitude.
  # @return <Weather4Me::Location> or nil if not found.
  def self.find_for_location_string(location_s)
    return nil if location_s.blank?

    # Maybe typing exact address or zip code, here can search in DB and save Geocoder request.
    location = self.where("address LIKE ? OR zip_code=?", "%#{location_s}%", location_s).first
    return location if location

    logger.debug "-> Geocoder location: #{location_s}"
    result = Geocoder.search(location_s).first
    return nil if result.nil?

    zip = result&.postal_code
    if zip.blank? # position not precise enough
      mresult = Geocoder.search("#{result.latitude}, #{result.longitude}")
      result = mresult.find{|r| r.postal_code.present? }
      zip = result&.postal_code
    end
    
    if zip.present?
      location = Weather4Me::Location.find_or_create_by(zip_code: zip) do |loc|
        loc.city = result&.city
        loc.state = result&.state
        loc.country = result&.country
        loc.latitude = result&.latitude
        loc.longitude = result&.longitude
      end
    end
    location
  end

  private

  # Zip code's format might not be standardized
  def normalize_attributes
    if is_country_us?
      self.country = 'United States'
      self.zip_code = zip_code.match(/\A([\d]{4,5})([\s\-]\d+)?/).try(:[], 1) if zip_code.present? # keep only 1st 5 digits
    end
  end
end
