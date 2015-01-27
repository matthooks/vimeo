module Vimeo
  class Response
    def initialize response
      @headers  = response.headers
      @status   = response.status
      @body     = symbolize_keys! response.body
    end

    def parse_response_or_fail
      error = error(@headers, @status, @response)
      @body
    end

    protected

    def error(headers, status, response)
    end

    def symbolize_keys! object
      if object.is_a?(Array)
        object.each_with_index do |val, index|
          object[index] = symbolize_keys!(val)
        end
      elsif object.is_a?(Hash)
        object.keys.each do |key|
        object[key.to_sym] = symbolize_keys!(object.delete(key))
        end
      end
      object
    end
  end
end