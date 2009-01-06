module Vimeo
  module Simple

    class Base      
      include HTTParty
      base_uri 'vimeo.com/api'
      
      # TODO: Format options
    end

  end # Simple
end # Vimeo