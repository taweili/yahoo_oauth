module YahooOAuth
  class Client
        
  end
    
  class YahooObject
    def initialize(oid, client)
      @oid = oid
      @client = client
    end
    
    def info
      @client.send(:_get, @oid)
    end
    
    def method_missing(method, *args)
      if args.first and args.first == :create
        @client.send(:_post, "/#{@oid}/#{method.to_s}", args.last)
      else
        @client.send(:_get, "/#{@oid}/#{method.to_s}")
      end
    end
    
  end
end