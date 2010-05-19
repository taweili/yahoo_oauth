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
