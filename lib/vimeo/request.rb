require 'faraday'

module Vimeo
  ##
  # This class is the one creating
  class Request

    ##
    # this stores the faraday connection instance that will be making the
    # request to the Vimeo api
    attr_accessor :performer

    ##
    #
    def initialize client, method, path, params, body
      # set our dependencies
      @client, @method, @path, @params, @body = client, method, path, params, body
      # we're required to have the access token now so raise an exception
      # if it hasn't been set
      raise Vimeo::Error::AccessTokenNotSet unless @client.access_token?
      # create a new faraday instance to use as our HTTP client
      @performer = Faraday.new url: Vimeo::Client::BASE do |faraday|
        faraday.request  :multipart
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    ##
    #
    def perform
      begin
        perform_request
      rescue Vimeo::Exception
        false
      end
    end

    def perform!
      perform_request
    end

    protected
    # :nodoc:
    def method_expects_body?
      %i(post put path).include?(@method)
    end

    private

    def perform_request
      # construct the headers for the requset for given params
      headers = Vimeo::Headers.new(@client).request_headers
      # faraday uses a different set of method signitures depending on what
      # type of method is being called
      args = method_expects_body? ?
         [@method, @path, @body, headers] : [@method, @path, @params, headers]
      # perform the request with faraday
      response = @performer.public_send *args
      # parse the response
      Vimeo::Response.new(response.to_hash).parse_response_or_fail
    end
  end
end