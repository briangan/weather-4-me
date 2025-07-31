# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

WEATHER_API_KEY = ENV['WEATHER_API_KEY'] || 'fc5febf1a5fb4cbda8b212937253007'