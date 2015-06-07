module Vimeo
  module Endpoints
    module Me
      include Vimeo::Helpers

      ##
      # Get the current user associated with the access token
      def me
        perform_get_with_object("/me", {}, Vimeo::Entities::Me)
      end
    end
  end
end