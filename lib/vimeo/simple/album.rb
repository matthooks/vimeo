module Vimeo
  module Simple

    class Album < Vimeo::Simple::Base
      # Returns this album's clips.
      def self.clips(album_id)
        get("/album/#{album_id}/clips.json")
      end

      # Returns this album's information.
      def self.info(album_id)
        get("/album/#{album_id}/info.json")
      end
    end

  end # Simple
end # Vimeo