require 'test_helper'
require 'yahoo_oauth/client'

class ClientTest < Test::Unit::TestCase
  context "A Client instance" do
    setup do
    end

    should "return its full name" do
      client = YahooOAuth::Client.new
    end
  end
end
