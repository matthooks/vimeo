module Vimeo
  module Endpoints
    module Tags
      include Vimeo::Helpers

      ##
      # Get a Tag
      #
      # *word:* the tag's name
      def tag word
        perform_get_with_object("/tags/#{word}", {}, Vimeo::Entities::Tag)
      end
    end
  end
end