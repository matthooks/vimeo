module Vimeo
  module Helpers
    def perform_get_with_object(path, options, klass)
      perform_request_with_object(:get, path, options, klass)
    end

    def perform_request(method, path, options)
      Vimeo::Request.new(method, path, options).perform
    end

    def perform_request_with_object(method, path, options, klass)
      response = perform_request(method, path, options)
      klass.new(response)
    end
  end
end