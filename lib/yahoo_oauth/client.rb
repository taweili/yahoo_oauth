require 'yahoo_oauth/objects'

module YahooOAuth
  class Client
    
    def initialize(options = {})
      options = ::YAHOO_OAUTH_CREDENTIALS.merge(options)
      @consumer_key = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @callback = options[:callback]
      @token = options[:token]
      @secret = options[:secret]
    end
  
    def authorize_url(options = {})
      @request_token ||= consumer.get_request_token(:oauth_callback => options[:callback] || @callback)
      return @request_token.authorize_url
    end
    
    def authorize(options = {})
      @access_token = @request_token.get_access_token(:oauth_verifier => options[:oauth_verifier])
      @token = @access_token.token
      @secret = @access_token.secret
      @access_token
    end
    
    def authorized?
      access_token.get("http://social.yahooapis.com/v1/me/guid?format=json")
    end
  
    private
      def consumer
        @consumer ||= OAuth::Consumer.new(@consumer_key,
                                          @consumer_secret,
                                          :site => "https://api.login.yahoo.com",
                                          :request_token_path => '/oauth/v2/get_request_token', 
                                          :access_token_path => '/oauth/v2/get_token', 
                                          :authorize_path => '/oauth/v2/request_auth')
      end
      
      def access_token
        @access_token ||= OAuth::AccessToken.new(consumer, @token, @secret)
      end
            
      def _get(url)
        oauth_response = access_token.get(url)
        JSON.parse(oauth_response)
      end

      def _post(url, params={}, headers={})
        oauth_response = access_token.post(url, params, headers)
        JSON.parse(oauth_response)
      end

      def _delete(url)
        oauth_response = access_token.delete(url)
        JSON.parse(oauth_response)
      end
  end
end
   
