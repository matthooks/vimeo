module Vimeo
  module Advanced

    class Test < Vimeo::Advanced::Base
      # An echo test. Echoes all parameters.
      # Options can be anything except method, api_key,
      # and api_sig -- if any of these options are
      # present they will be overwritten by the proper
      # values.
      def echo(options={})
        options.merge!(:method => "vimeo.test.echo")
        api_sig = generate_api_sig options
        options.merge!(:api_sig => api_sig)
        self.class.post("/api/rest", :query => options)
      end

      # A null test.
      def null(auth_token)
        sig_options = {
          :auth_token => auth_token,
          :method => "vimeo.test.null"
        }
        
        make_request sig_options
      end

      # Tests if the user associated to this token
      # is able to make authenticated calls.
      def login(auth_token)
        sig_options = {
          :auth_token => auth_token,
          :method => "vimeo.test.login"
        }
        
        make_request sig_options
      end
    end

  end # Advanced
end # Vimeo