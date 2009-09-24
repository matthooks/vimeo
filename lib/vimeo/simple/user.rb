module Vimeo
  module Simple

    class User < Vimeo::Simple::Base
      # Returns this user's information.
      def self.info(username)
        get("/#{username}/info.json")
      end
      
      # Returns this user's videos.
      def self.videos(username)
        get("/#{username}/videos.json")
      end
    
      # Returns this user's liked videos.
      def self.likes(username)
        get("/#{username}/likes.json")
      end
    
      # Returns the videos this user appears in.
      def self.appears_in(username)
        get("/#{username}/appears_in.json")
      end
    
      # Returns all videos related to this user.
      def self.all_videos(username)
        get("/#{username}/all_videos.json")
      end
    
      # Returns this user's subscriptions.
      def self.subscriptions(username)
        get("/#{username}/subscriptions.json")
      end
    
      # Returns this user's albums.
      def self.albums(username)
        get("/#{username}/albums.json")
      end
    
      # Returns this user's channels.
      def self.channels(username)
        get("/#{username}/channels.json")
      end
    
      # Returns this user's groups.
      def self.groups(username)
        get("/#{username}/groups.json")
      end
    
      # Returns this user's contact's videos.
      def self.contacts_videos(username)
        get("/#{username}/contacts_videos.json")
      end
    
      # Returns the videos that this user's contact's liked.
      def self.contacts_like(username)
        get("/#{username}/contacts_like.json")
      end
    end

  end # End Simple
end # End Vimeo