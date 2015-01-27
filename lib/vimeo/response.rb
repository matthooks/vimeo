require "json"

module Vimeo
  class Response
    def initialize response
      @headers  = response.headers
      @status   = response.status
      @body     = response.body
    end

    def parse_response_or_fail
      error = error(@headers, @status, @response)
      body  = parse(@body)
    end

    protected

    def error(headers, status, response)
    end

    def parse response
      JSON.parse(response, symbolize_names: true)
    end
  end
end