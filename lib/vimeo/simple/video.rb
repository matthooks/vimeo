module Vimeo
  module Simple

    class Video < Vimeo::Simple::Base
      # Returns this video's information.
      #
      # @param [String] video_id The video's id or a valid vimeo url.
      def self.info(video_id)
        video_id.to_s.match(/(?:http(?:s)?:\/\/)?vimeo.com\/(\d+)/)
        get("/video/#{$1 || video_id}.json")
      end
    end

  end # End Simple
end # End Vimeo