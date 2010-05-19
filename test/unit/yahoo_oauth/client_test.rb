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
      assert url
    end
    
    should "get a authorized client with token and secert" do 
      client = YahooOAuth::Client.new(:token => YAHOO_ACCESS_TOKEN, :secret => YAHOO_ACCESS_SECRET, :callback => YAHOO_OAUTH_CALLBACK)
      assert client.authorized?
    end
  end
  
end
