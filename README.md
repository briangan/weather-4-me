# README

This is a Ruby on Rails web application to fetch location-based weather forecasts.  Current source of the forecast data is from weatherapi.com.  Different API can be implemented as alternative source.

Things you may want to cover:
* Ruby Environment
* Rubygems in Use
* Project Structure
* API
* Database
* Testing
* Deployment
* TODOs and Future Design

######################################################

# Ruby Environment
Ruby interpretor: 3.2.6 Tested
Rails: 6.1.7

Check Installation section for guide to setup the RoR environment.

# Rubygems in Use
rails 6.1.x

For those who use a Mac computer or ARM CPU architecture like me, 
Ruby 3.2 + Rails 6 might break upon conole or server launch w/ 
uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger (NameError).
The workaround is to use older version of concurrent-ruby 1.3.4
concurrent-ruby 1.3.4

# Project Structure


# API

The current 3rd party source of the weather data is from WeatherAPI.  The API key associated has a 
default trial account value expiring on 2025/8/13.  It can overriden by setting 
environment variable WEATHER_API_KEY.

If other source of weather API is wanted as alternative data, implement some class to fetch and 
convert into DayForecast records.  Then change Weather4Me::ForecastAPI.forecast to use that source.


# Database
Currently for development the database source used the local SQLite inside /db folder.
For production level, suggest to use independent relational database like MySQL or PostgreSQL.  And update configuration in config/database.yml.

# Deoployment

Download this from GitHub repository.  Then enter the folder weather-4-me and 
setup the Ruby on Rails framework.

Suggestion is to use rvm or rbenv to install specific version of Ruby, like
rvm install 3.2.6
rvm use 3.2.6

Make sure correct Rails is installed completely.  
gem install bundler
gem uninstall concurrent-ruby
gem install concurrent-ruby -v '1.3.4'
bundle install


# TODOs and Future Design

Forecast Data
[ ] HTTP Request to API service to get JSON
  [ ] convert to Forecast and save
  [ ] alert if request fails
[ ] Hourly data that allows scrolling down forecast of individual hours since now.

Forecast View
[ ] Based on given address, search for Forecast records to display
  [ ] DB query Forecast for existing, non-expiring (30 mins) saved result
  [ ] If no saved, non-expiring result, fetch & parse from API service

Locations
[ ] Parse API service normalized/standardized location.  Find by city + state + country or create the location.
[ ] If API service data does not container zip_code, find service to convert address to get zip_code
  [ ] Use geocoder
[ ] Save favorite or recent locations; and show on homepage
[ ] A database of locations 


# Notes

* Development steps

bin/rails g migration CreateLocation city:string state:string country:string zip_code:string longitude:float latitude:float

bin/rails g scaffold Weather4Me::Forecast location_id:integer current_temp:integer low_temp:integer high_temp:integer condition:string forecast_time:datetime expires_at:datetime
