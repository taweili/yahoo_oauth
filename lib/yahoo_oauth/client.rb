require 'yahoo_oauth/objects'

module YahooOAuth
  class Client
    
    def initialize(options = {})
      @consumer_id = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @callback = options[:callback]
      @token = options[:token]
    end
  
    def authorize_url(options = {})
      request_token = consumer.get_request_token(:oauth_callback => options[:callback] || @callback)
      return request_token.authorize_url
    end
    
    def authorize(options = {})
      @access_token ||= consumer.web_server.get_access_token(
        options[:code],
        :redirect_uri => options[:callback] || @callback
      )
      @token = @access_token.token
      @access_token
    end
    
    private
      def consumer
        @consumer ||= OAuth::Consumer.new(@consumer_id,
                                          @consumer_secret,
                                          :site => "https://api.login.yahoo.com",
                                          :request_token_path => '/oauth/v2/get_request_token', 
                                          :access_token_path => '/oauth/v2/get_token', 
                                          :authorize_path => '/oauth/v2/request_auth')
      end

      def access_token
        OAuth::AccessToken.new(consumer, @token)
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
   
