#
# A Ruby Library for Yahoo! Social API
#
# Author::    David Li (mailto:taweili@yahoo.com)
# Copyright:: Copyright (c) 2010 David Li
# License::   LGPL

# Provides Social Directory API
# http://developer.yahoo.com/social/rest_api_guide/social_dir_api.html
module YahooOAuth
  class Client
    
    #
    # GUID of the authorized user
    # http://developer.yahoo.com/social/rest_api_guide/introspective-guid-resource.html
    #
    def guid
      @guid ||= _get_guid
    end
    
    #
    # Tinyusercard Profile
    # http://developer.yahoo.com/social/rest_api_guide/tiny-profile-resource.html
    #
    def tinyusercard(_guid = nil)
      _guid ||= guid
      res = JSON.parse(access_token.get("http://social.yahooapis.com/v1/user/#{_guid}/profile/tinyusercard?format=json").body)
    end
    
    #
    # Usercard Profile
    # http://developer.yahoo.com/social/rest_api_guide/usercard-resource.html
    #
    def usercard(_guid = nil)
      _guid ||= guid
      res = JSON.parse(access_token.get("http://social.yahooapis.com/v1/user/#{_guid}/profile/usercard?format=json").body)
    end
        
    private 
    
    def _get_guid
      res = JSON.parse(access_token.get("http://social.yahooapis.com/v1/me/guid?format=json").body)
      res["guid"]["value"]
    end
  end
end