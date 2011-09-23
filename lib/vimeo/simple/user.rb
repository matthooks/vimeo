module Vimeo
  module Simple

    class User < Vimeo::Simple::Base
      # Returns a user's metadata.
      #
      # @param [String] username The user's id or username.
      def self.info(username)
        get("/#{username}/info.json")
      end
      
      # Returns a list of a user's videos.
      #
      # @param [String] username The user's id or username.
      # @param [Integer] page, is the desired Page (1, 2, or 3. Default is 1) 
      def self.videos(username, page=1)
        if page
          get("/#{username}/videos.json?page=#{page}")          
        else
          get("/#{username}/videos.json")
        end
      end
    
      # Returns a list of a user's liked videos.
      #
      # @param [String] username The user's id or username.
      def self.likes(username)
        get("/#{username}/likes.json")
      end
    
      # Returns a list of the videos a user appears in.
      #
      # @param [String] username The user's id or username.
      def self.appears_in(username)
        get("/#{username}/appears_in.json")
      end
    
      # Returns a list of all videos that are related to a user.
      #
      # @param [String] username The user's id or username.
      def self.all_videos(username)
        get("/#{username}/all_videos.json")
      end
    
      # Returns a list of a user's subscriptions.
      #
      # @param [String] username The user's id or username.
      def self.subscriptions(username)
        get("/#{username}/subscriptions.json")
      end
    
      # Returns a list of a user's albums.
      #
      # @param [String] username The user's id or username.
      def self.albums(username)
        get("/#{username}/albums.json")
      end
    
      # Returns a list of a user's channels.
      #
      # @param [String] username The user's id or username.
      def self.channels(username)
        get("/#{username}/channels.json")
      end
    
      # Returns a list of a user's groups.
      #
      # @param [String] username The user's id or username.
      def self.groups(username)
        get("/#{username}/groups.json")
      end
    
      # Returns a list of a user's contact's videos.
      #
      # @param [String] username The user's id or username.
      def self.contacts_videos(username)
        get("/#{username}/contacts_videos.json")
      end
    
      # Returns a list of videos that a user's contacts liked.
      #
      # @param [String] username The user's id or username.
      def self.contacts_like(username)
        get("/#{username}/contacts_like.json")
      end
    end

  end # End Simple
end # End Vimeo