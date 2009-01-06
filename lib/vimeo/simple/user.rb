module Vimeo
  module Simple

    class User < Vimeo::Simple::Base
      # Returns this user's information.
      def self.info(username)
        get("/#{username}/info.json")
      end
      
      # Returns this user's clips.
      def self.clips(username)
        get("/#{username}/clips.json")
      end
    
      # Returns this user's liked clips.
      def self.likes(username)
        get("/#{username}/likes.json")
      end
    
      # Returns the clips this user appears in.
      def self.appears_in(username)
        get("/#{username}/appears_in.json")
      end
    
      # Returns all clips related to this user.
      def self.all_clips(username)
        get("/#{username}/all_clips.json")
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
    
      # Returns this user's contact's clips.
      def self.contacts_clips(username)
        get("/#{username}/contacts_clips.json")
      end
    
      # Returns the clips that this user's contact's liked.
      def self.contacts_like(username)
        get("/#{username}/contacts_like.json")
      end
    end

  end # End Simple
end # End Vimeo