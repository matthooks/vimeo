module Vimeo
  module Simple
    
    class Base      
      include HTTParty
      base_uri 'https://vimeo.com/api/v2'
    end # Base

  end # Simple
end # Vimeo