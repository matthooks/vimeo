module Vimeo
  module Endpoints
    module Tags
      include Vimeo::Helpers

      ##
      # Get a Tag
      def tag word, options = {}
        perform_get_with_object("/tags/#{word}", options, Vimeo::Entities::Tag)
      end
    end
  end
end