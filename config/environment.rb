# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ForecastIO.api_key = ENV["FORECAST_IO_API_KEY"]
