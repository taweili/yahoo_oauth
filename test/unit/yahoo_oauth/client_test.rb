require 'test_helper'
require 'yahoo_oauth'
require 'yahoo_config'

class ClientTest < Test::Unit::TestCase
  context "A Client instance" do
    setup do
    end

    should "get a authorize_url" do
      client = YahooOAuth::Client.new(:consumer_key => YAHOO_CONSUMER_KEY,
                                      :consumer_secret => YAHOO_SECRET_KEY,
                                      :callback => YAHOO_OAUTH_CALLBACK)
      url = client.authorize_url
      puts url
    end
  end
end
