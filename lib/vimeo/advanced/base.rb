module Vimeo
  module Advanced

    class Base
      include HTTParty
      base_uri 'vimeo.com'

      # TODO: Pass an auth token, if you've already got one
      # TODO: implement format_options
      # Requires your API key and secret phrase.
      # The API key and secret are prepended to every request.
      def initialize(api_key, secret, format_options={})
        @auth = { :api_key => api_key }
        @secret = secret
      end
      
      # Generates a link that allows a user to authorize
      # your web application to use the advanced API
      def login_link(perms)
        api_sig = generate_api_sig :perms => perms
        "http://vimeo.com/services/auth/?api_key=#{@auth[:api_key]}&perms=#{perms}&api_sig=#{api_sig}"
      end

      # TODO: Implement a function that returns the correct upload URL

      # Generates the proper API signature for a file upload.
      def upload_sig(ticket_id, auth_token)
        sig_options = {
          :ticket_id => ticket_id,
          :auth_token => auth_token
        }

        generate_api_sig sig_options
      end
      
      private

      # Generates a MD5 hashed API signature for Advanced API requests
      def generate_api_sig(options={})
        # Every request requires the api_key parameter
        options.merge! @auth
        # Keys must be sorted alphabetically
        api_sig = options.sort { |a, b| a.to_s <=> b.to_s }.join
        Digest::MD5.hexdigest("#{@secret}#{api_sig}")
      end
      
      def query(sig_options, api_sig)
        sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
      end
      
      def make_request(sig_options)
        api_sig = generate_api_sig sig_options
        self.class.post "/api/rest", :query => query(sig_options, api_sig)
      end

    end # Base

  end # Advanced
end # Vimeo