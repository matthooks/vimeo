require "open-uri"

module Vimeo
  module Simple
    
    class Base
      BASE_URL = 'vimeo.com/api/v2'
      
      def self.get(path)
        Vimeo.parse_json(open("http://#{BASE_URL}#{path}").read)
      end
    end # Base
  end # Simple
end # Vimeo