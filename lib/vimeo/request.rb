require "faraday"

module Vimeo
  ##
  #
  class Request
    BASE = "https://api.vimeo.com"

    ##
    #
    def initialize(client, method, path, options = {})
      # set our dependencies
      @client, @method, @path, @options = client, method, path, options

      # we're required to have the access token now so raise an exception
      # if it hasn't been set
      raise Vimeo::AccessTokenNotSet unless @client.access_token?

      # create a new faraday instance to use as our HTTP client
      @conn = Faraday.new(url: BASE) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def perform
      # construct the headers for the requset for given params
      headers  = Vimeo::Headers.new(@client).request_headers
      # make and parse the response from Vimeo
      response = @conn.public_send(@method, @path, @options, headers)
      Vimeo::Response.new(response).parse_response_or_fail
    end
  end
end