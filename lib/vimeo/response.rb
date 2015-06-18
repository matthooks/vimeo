require "json"

module Vimeo
  class Response
    def initialize response
      @headers, @status, @body = response[:headers], response[:status], response[:body]
    end

    def parse_response_or_fail
      # fetch
      error = error(@headers, @status, @response)
      # raise an exception if an error has occured
      fail(error, error_from_response) if error
      # parse the response body
      body = parse(@body)
    end

    protected

    def error(headers, status, response)
      # set a generic 500 error if the response has any 5xx status
      status = 500 if status / 100 == 5
      # fetch the appropiate exception by the status code
      klass = Vimeo::Error::ERRORS[status]
    end

    ##
    # naive implementation, i know. I have plans to make this better
    def parse response
      JSON.parse(response, symbolize_names: true)
    end

    def error_from_response
      response = JSON.parse(@body, symbolize_names: true)
      response[:error] if response.has_key? :error
    end
  end
end