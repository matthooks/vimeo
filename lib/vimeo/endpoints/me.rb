module Vimeo
  module Endpoints
    module Me
      include Vimeo::Helpers

      ##
      # Get the current user
      def me
        perform_get_with_object("/me", {}, Vimeo::Entities::Me)
      end
    end
  end
end