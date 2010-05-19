require 'test_helper'


class ClientTest < Test::Unit::TestCase
  context "Client" do

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
  
  context "Expired Client" do
    setup do
      @client = YahooOAuth::Client.new(:token => YAHOO_ACCESS_TOKEN_EXPIRED, :secret => YAHOO_ACCESS_SECRET_EXPIRED)
    end

    should "get a OAuth::Problem with token_expired when invoking methods" do
      exp =  assert_raise OAuth::Problem do 
        @client.tinyusercard
      end
      assert_equal exp.problem, "token_expired"
    end
    
    should "use refresh to fix the problem" do
      resp = @client.refresh_access_token
      assert = @client.tinyusercard
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
    
    should "get the tinyusercard of the authorized user" do
      res = @client.tinyusercard
      assert_equal res["profile"]["guid"], YAHOO_XOAUTH_YAHOO_GUID
    end
    
    should "get the usercard of the authorized user" do
      res = @client.usercard
      assert_equal res["profile"]["guid"], YAHOO_XOAUTH_YAHOO_GUID
    end
  end
  
end
