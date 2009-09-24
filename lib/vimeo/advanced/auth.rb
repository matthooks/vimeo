module Vimeo
  module Advanced
    class Auth < Vimeo::Advanced::Base
      
      # Tests the validity of an authorization token.
      create_api_method :check_token,
                        "vimeo.auth.checkToken",
                        :required => [:auth_token]

      # Obtains a frob.
      # Used for desktop based authentication.
      create_api_method :get_frob,
                        "vimeo.auth.getFrob"

      # Obtains an authorization token.
      create_api_method :get_token,
                        "vimeo.auth.getToken",
                        :required => [:frob]

    end
  end # Advanced
end # Vimeo