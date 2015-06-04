require "hashie"

module Vimeo
  class Base < ::Hashie::Mash

    attr_reader :client

    def initialize attrs
      @super = attrs.delete(:client)
      super attrs
    end

    private
    def get_id
      id || uri.match(/(\d+)/).captures.first
    end
  end
end