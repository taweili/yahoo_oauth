require 'test_helper'


class ClientTest < Test::Unit::TestCase
  context "Client" do
    setup do
    end

    should "get a authorize_url" do
      client = YahooOAuth::Client.new(:consumer_key => YAHOO_CONSUMER_KEY,
                                      :consumer_secret => YAHOO_SECRET_KEY,
                                      :callback => YAHOO_OAUTH_CALLBACK)
      url = client.authorize_url
      assert url
      assert url.include? "https://api.login.yahoo.com/oauth/v2/request_auth?oauth_token="
    end
    
    should "not be authorized without token and secret" do
      client = YahooOAuth::Client.new(:callback => YAHOO_OAUTH_CALLBACK)
      assert !client.authorized?
    end
    
    should "get a authorized client with token and secert" do 
      client = YahooOAuth::Client.new(:token => YAHOO_ACCESS_TOKEN, :secret => YAHOO_ACCESS_SECRET)
      assert client.authorized?
    end
  end
  
  context "Social Directory API" do 
    setup do
      @client = YahooOAuth::Client.new(:token => YAHOO_ACCESS_TOKEN, :secret => YAHOO_ACCESS_SECRET)
    end
    
    should "get the guid of the authorized user" do
      guid = @client.guid
      assert guid
    end
  end
  
end
