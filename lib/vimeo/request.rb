require "faraday"
require "json"
require 'uri'

module Vimeo
  ##
  #
  class Request
    BASE = "https://api.vimeo.com"

    def initialize(client, method, path, params = {}, body)
      # set our dependencies
      @client, @method, @path, @params, @body = client, method, path, params, body
      # we're required to have the access token now so raise an exception
      # if it hasn't been set
      raise Vimeo::Error::AccessTokenNotSet unless @client.access_token?
      # create a new faraday instance to use as our HTTP client
      @conn = Faraday.new(url: BASE) do |faraday|
        faraday.request  :multipart
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def perform
      # construct the headers for the requset for given params
      headers = Vimeo::Headers.new(@client).request_headers
      # make params an empty string if its empty
      params = @params.empty? ? "" : @params
      # faraday uses a different set of method signitures depending on what
      # type of method is being called
      args = method_expects_body? ?
        [@method, @path, params, headers] : [@method, @path, @body, headers]
      # perform the request with faraday
      response = @conn.public_send *args
      # parse the response2
      Vimeo::Response.new(response).parse_response_or_fail
    end

    protected
    # :nodoc:
    def method_expects_body?
      [:post, :put, :path].include?(@method)
    end
  end
end