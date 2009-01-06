module Vimeo
  module Advanced

    class Auth < Vimeo::Advanced::Base
      # Obtains an authorization token.
      def get_token(frob)
        sig_options = {
          :frob => frob,
          :method => "vimeo.auth.getToken"
        }
        
        make_request sig_options
      end

      # Obtains a frob.
      # Used for desktop based authentication.
      def get_frob
        sig_options = { :method => "vimeo.auth.getFrob" }
        
        make_request sig_options
      end

      # Tests the validity of an authorization token.
      def check_token(auth_token)
        sig_options = {
          :auth_token => auth_token,
          :method => "vimeo.auth.checkToken"
        }
        
        make_request sig_options
      end

    end

  end # Advanced
end # Vimeo