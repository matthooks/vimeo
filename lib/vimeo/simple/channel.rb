module Vimeo
  module Simple

    class Channel < Vimeo::Simple::Base      
      # Returns this channel's videos.
      def self.videos(channelname)
        get("/channel/#{channelname}/videos.json")
      end
      
      # Returns this channel's information.
      def self.info(channelname)
        get("/channel/#{channelname}/info.json")
      end
    end

  end # Simple
end # Vimeo