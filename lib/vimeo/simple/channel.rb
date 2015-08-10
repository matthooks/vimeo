module Vimeo
  module Simple

    class Channel < Vimeo::Simple::Base      
      # Returns a list of a channel's videos.
      #
      # @param [String] channelname The channel's name.
      # @param [Integer] page, is the desired Page (1, 2, or 3. Default is 1) 
      def self.videos(channelname, page=1)
        get("/channel/#{channelname}/videos.json?page=#{page}")
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
