module Vimeo
  module Simple

    class Base      
      include HTTParty
      base_uri 'vimeo.com/api/v2'
      
      # TODO: Format options
    end

  end # Simple
end # Vimeo