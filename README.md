# README

This is a Ruby on Rails web application to fetch location-based weather forecasts.  Current source of the forecast data is from weatherapi.com.

Things you may want to cover:
* Ruby Environment
* Rubygems in Use
* Project Structure
* API
* Database
* Testing
* Deployment

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
