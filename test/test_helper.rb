require 'rubygems'
require 'test/unit'
require 'shoulda'

require 'yahoo_oauth'

#
# Setup the Yahoo credentials and User token and secret to use with tests
#
# YAHOO_CONSUMER_KEY=""
# YAHOO_SECRET_KEY=""
# YAHOO_OAUTH_CALLBACK=""
# YAHOO_ACCESS_TOKEN=""
# YAHOO_ACCESS_SECRET=""
require 'yahoo_config'

YAHOO_OAUTH_CREDENTIALS = {
  :consumer_key => YAHOO_CONSUMER_KEY,
  :consumer_secret => YAHOO_SECRET_KEY
} if !defined? YAHOO_OAUTH_CREDENTIALS

begin
  client = YahooOAuth::Client.new(:token => YAHOO_ACCESS_TOKEN, :secret => YAHOO_ACCESS_SECRET)
  client.tinyusercard
rescue OAuth::Problem
  client = YahooOAuth::Client.new(:token => YAHOO_ACCESS_TOKEN, :secret => YAHOO_ACCESS_SECRET)
  access_token = client.refresh_access_token
  puts "Please update the token and secret in 'yahoo_config.rb'"
  puts "YAHOO_ACCESS_TOKEN=\"#{access_token.token}\""
  puts "YAHOO_ACCESS_SECRET=\"#{access_token.secret}\""
  exit
end
