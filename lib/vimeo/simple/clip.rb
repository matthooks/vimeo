module Vimeo
  module Simple

    class Clip < Vimeo::Simple::Base
      # Returns this clip's information.
      def self.info(video_id)
        get("/clip/#{video_id}.json")
      end
    end

  end # End Simple
end # End Vimeo