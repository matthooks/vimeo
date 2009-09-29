module Vimeo
  module Simple

    class Album < Vimeo::Simple::Base
      # Returns a list of an album's videos.
      #
      # @param [String] album_id The album's id.
      def self.videos(album_id)
        get("/album/#{album_id}/videos.json")
      end

      # Returns an album's metadata.
      #
      # @param [String] album_id The album's id.
      def self.info(album_id)
        get("/album/#{album_id}/info.json")
      end
    end

  end # Simple
end # Vimeo