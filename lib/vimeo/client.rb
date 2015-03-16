module Vimeo
  ##
  # This class provides the public APIs' used to interface with the Vimeo API
  class Client
    include Vimeo::Endpoints::Categories
    include Vimeo::Endpoints::Channels
    include Vimeo::Endpoints::Groups
    include Vimeo::Endpoints::Tags
    include Vimeo::Endpoints::Me

    # Vimeo access token (see: https://developer.vimeo.com/apps)
    attr_accessor :access_token

    ##
    # Create a new Client object. You can either supply a hash of +options+
    # or a block as per the example:
    #
    # Vimeo::Client.new do |client|
    #   client.access_token = 'myvimeoaccesstoken'
    # end
    #
    # options = { access_token: 'myvimeoaccesstoken' }
    # Vimeo.client.new options
    def initialize options = {}
      options.each do |k,v|
        instance_variable_set "@#{k}", v
      end
      yield self if block_given?
    end

    def access_token?
      !!(access_token)
    end
  end
end