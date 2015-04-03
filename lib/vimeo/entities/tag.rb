module Vimeo
  module Entities
    class Tag < Vimeo::Base
      ##
      # Get a list of videos associated with a tag.
      def videos
        perform_get_with_object("/tags/#{get_id}/videos", options, Vimeo::Entities::Video)
      end
    end
  end
end