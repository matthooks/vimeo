require "hashie"

module Vimeo
  class Base < ::Hashie::Mash
    def initialize client, attrs = {}
      @client = client
      super attrs
    end
  end
end