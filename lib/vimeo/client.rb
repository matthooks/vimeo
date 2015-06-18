require "oauth2"

module Vimeo
  ##
  # This class provides the public APIs' used to interface with the Vimeo API
  class Client
    include Vimeo::Endpoints::Videos
    include Vimeo::Endpoints::Categories
    include Vimeo::Endpoints::Channels
    include Vimeo::Endpoints::Groups
    include Vimeo::Endpoints::Tags
    include Vimeo::Endpoints::Users
    include Vimeo::Endpoints::Me
    include Vimeo::Upload

    # base url for the vimeo api endpoint
    BASE = "https://api.vimeo.com"

    # Access Token stores the token (see authentication) that *must* be provided
    # to make requests to the Vimeo API
    attr_accessor :access_token

    class << self
      ##
      # If OAuth authentication is needed this method returns an instance of an Oauth2
      # client (see https://github.com/intridea/oauth2) which as the appropiate
      # options set.
      # see authentication for more information.
      def new_oauth_request client_id, client_secret, identifier, scope = ["public"]
        params = { scope: scope.join(' '), state: identifier }
        OAuth2::Client.new(client_id, client_secret, site: BASE, connection_opts: { params: params })
      end
    end

    ##
    # Create a new Client object. You can either supply a hash of +options+
    # or a block, see example:
    #
    #   Vimeo::Client.new do |client|
    #     client.access_token = 'mytoken'
    #   end
    #
    #   // or
    #
    #   Vimeo.client.new { access_token: 'mytoken' }
    #
    def initialize options = {}
      options.each do |k,v|
        instance_variable_set "@#{k}", v
      end
      yield self if block_given?
    end

    # :nodoc:
    def access_token?
      !!(access_token)
    end
  end
end