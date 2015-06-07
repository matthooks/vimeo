module Vimeo
  module Endpoints
    module Videos
      include Vimeo::Helpers

      ##
      # Get a video
      #
      # *video_id:* the video's unqiue id
      def video video_id
        perform_get_with_object("/videos/#{video_id}", {}, Vimeo::Entities::Video)
      end
    end
  end
end