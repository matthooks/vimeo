require 'uri'

module Vimeo
  module Helpers
    def perform_get_with_object(path, options, klass)
      perform_request_with_object :get, path, options, klass
    end

    def perform_get(path, options)
      perform_request(:get, path, options)
    end

    def perform_patch(path, options)
      perform_request(:patch, path, options)
    end

    def perform_delete(path, options = {})
      perform_request(:delete, path, options)
    end

    def perform_post(path, options)
      perform_request(:post, path, options)
    end

    def perform_request(method, path, options)
      client = get_client_object
      encoded_options = encoded_options(options)
      Vimeo::Request.new(client, method, path, encoded_options).perform
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
        klass.new self, i
      end

      keys    = [:page, :per_page, :pages]
      values  = response.values_at(:page, :per_page, :paging)

      options = Hash[keys.zip(values)]

      Vimeo::Collection.new(items, options)
    end

    def response_is_collection? response
      !!response.include?(:page)
    end

    def get_client_object
      @client || self
    end

    def encode_params params
      JSON.generate(options)
    end
  end
end