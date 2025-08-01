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

## Ruby Environment
Ruby interpretor: 3.2.6 Tested
Rails: 6.1.7

Check Installation section for guide to setup the RoR environment.

## Rubygems in Use
rails 6.1.x

For those who use a Mac computer or ARM CPU architecture like me, 
Ruby 3.2 + Rails 6 might break upon conole or server launch w/ 
uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger (NameError).
The workaround is to use older version of concurrent-ruby 1.3.4

## Project Structure
** Important files and folders

```
.gitignore - file to configure GIT repository settings like excludes
app
  channels - handlers of channel streaming 
  controllers - classes to handle requests
  helpers - classes that contain helping methods for view level to use
  javascript - generated JS files used by webpack 
  jobs - scripts to run codes separate from server process
  mailers - email generator of various templates & data
  models - objects mapping attributes of data table
  services - utility classes other than controllers, jobs,
  views - pages for different controller methods/routes
bin - contains generated executives like rails, rake using specified RoR versions
config
  credentials - encrypted setting file
  environments - Rails environment based settings
  initializers - the codes that run at launch of server
  locals - dictionaries of wording for various language locales
  webpack - Rails environment based JS pack settings
db
  migrate - sequence of DB related changes
  development.sqlite3 - default data file for SQLite database
  weatherapi_forecast.yml - sample of output of weatherapi.com forecast API request in YAML format
lib - other classes and methods to be includes
log - various Rails environment log files
test - various types of tests to validate code implementations
Gemfile - Rubygems to use
```

## API

Access keys inside credentials like:
```
apis:
  weatherapi: "xxxxxxxxxxxxx"
  google_maps: "yyyyyyyyyyyyyyy"
```

## Weather API Service
The current 3rd party source of the weather data is from WeatherAPI.  The access API is based on
1st the credentials then next environment variable WEATHER_API_KEY

If other source of weather API is wanted as alternative data, implement some class to fetch and 
convert into DayForecast records.  Then change Weather4Me::ForecastAPI.forecast to use that source.

** Google Geocoder
The Geocoder API is based on 1st the credentials then next environment variable GOOGLE_MAPS_API_KEY


## Database
Currently for development the database source used the local SQLite inside /db folder.
For production level, suggest to use independent relational database like MySQL or PostgreSQL.  And update configuration in config/database.yml.

## Deoployment

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


## TODOs and Future Design
```
Forecast Data
[x] HTTP Request to API service to get JSON
  [x] convert to Forecast and save
  [x] alert if request fails
[x] Hourly data that provides the forecast of individual hours since now.

Forecast View
[x] Based on given address, search for Forecast records to display
  [x] DB query Forecast for existing, non-expiring (30 mins) saved result
  [x] If no saved, non-expiring result, fetch & parse from API service
[ ] Correct output of forecast_time to match timezone of location 
  * problem: Geocoder search doesn't provide timezone data; need separate request using timezone gem via Google service

Locations
[x] Parse API service normalized/standardized location.  Find by city + state + country or create the location.
[x] If API service data does not container zip_code, find service to convert address to get zip_code
  [x] Use geocoder
[x] Recent locations for pick
[ ] A database of locations for auto-complete
```

## Notes

** Development steps

bin/rails g migration CreateLocation city:string state:string country:string zip_code:string longitude:float latitude:float address:text

bin/rails g scaffold Weather4Me::Forecast location_id:integer current_temp:integer low_temp:integer high_temp:integer condition:string forecast_time:datetime

bin/rails g migration CreateHourlyForecasts location_id:integer time:datetime temp:integer condition:string