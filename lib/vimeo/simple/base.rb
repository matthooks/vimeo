module Vimeo
  module Simple
    
    class Base
      include HTTParty
      base_uri 'https://vimeo.com/api'
    end # Base
  end # Simple
end # Vimeo
