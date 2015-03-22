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
      fail(error) if error
      body  = parse(@body)
    end

    protected

    def error(headers, status, response)
      klass = Vimeo::Error::ERRORS[status]
    end

    ##
    # naive implementation, i know. I have plans to make this better
    def parse response
      JSON.parse(response, symbolize_names: true)
    end
  end
end