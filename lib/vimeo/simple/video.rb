module Vimeo
  module Simple

    class Video < Vimeo::Simple::Base
      # Returns this video's information.
      def self.info(video_id)
        get("/video/#{video_id}.json")
      end
    end

  end # End Simple
end # End Vimeo