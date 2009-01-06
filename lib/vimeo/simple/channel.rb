module Vimeo
  module Simple

    class Channel < Vimeo::Simple::Base      
      # Returns this channel's clips.
      def self.clips(channelname)
        get("/channel/#{channelname}/clips.json")
      end
      
      # Returns this channel's information.
      def self.info(channelname)
        get("/channel/#{channelname}/info.json")
      end
    end

  end # Simple
end # Vimeo