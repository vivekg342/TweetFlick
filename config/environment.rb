# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tweetflick::Application.initialize!
#MongoDB configuration file
Mongoid.load!('config/mongoid.yml')