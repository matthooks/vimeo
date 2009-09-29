module Vimeo
  module Simple

    class Channel < Vimeo::Simple::Base      
      # Returns a list of a channel's videos.
      #
      # @param [String] channelname The channel's name.
      def self.videos(channelname)
        get("/channel/#{channelname}/videos.json")
      end
      
      # Returns a channel's metadata.
      #
      # @param [String] channelname The channel's name.
      def self.info(channelname)
        get("/channel/#{channelname}/info.json")
      end
    end

  end # Simple
end # Vimeo