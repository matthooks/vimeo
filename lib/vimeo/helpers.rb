module Vimeo
  module Helpers
    def perform_get_with_object(path, options, klass)
      perform_request_with_object(:get, path, options, klass)
    end

    def perform_request(method, path, options)
      Vimeo::Request.new(self, method, path, options).perform
    end

    def perform_request_with_object(method, path, options, klass)
      response = perform_request(method, path, options)
      if response_is_collection? response
        build_collection_from_response(response, klass)
      else
        klass.new response
      end
    end

    def build_collection_from_response(response, klass)
      raw_items = response.fetch(:data)
      items = raw_items.collect do |i|
        klass.new i
      end

      keys    = [:page, :per_page, :pages]
      values  = response.values_at(:page, :per_page, :paging)

      options = Hash[keys.zip(values)]

      Vimeo::Collection.new(items, options)
    end

    def response_is_collection? response
      !!response.include?(:page)
    end
  end
end