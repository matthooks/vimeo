module Vimeo
  module Simple

    class Album < Vimeo::Simple::Base
      # Returns this album's videos.
      def self.videos(album_id)
        get("/album/#{album_id}/videos.json")
      end

      # Returns this album's information.
      def self.info(album_id)
        get("/album/#{album_id}/info.json")
      end
    end

  end # Simple
end # Vimeo