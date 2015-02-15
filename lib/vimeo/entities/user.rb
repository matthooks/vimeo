module Vimeo
  module Entities
    class User < Vimeo::Base
      include Vimeo::Helpers

      def USER_REOSURCE
        "/users/#{get_id}"
      end

      ##
      # Get a list of a users albumns
      def albums options = {}
        perform_get("#{USER_RESOURCE}/albumns", options)
      end

      ##
      # Get all videos the user appears in
      def appearances options = {}
        perform_get_with_object("#{USER_RESOURCE}/appearances", options, Vimeo::Entities::Video)
      end

      ##
      # The the list of channels a user follows
      def channels options = {}
        perform_get_with_object("#{USER_RESOURCE}/channels", options, Vimeo::Entities::Group)
      end

      ##
      # Get a list of the groups a user has joined
      def groups options ={}
        perform_get_with_object("#{USER_RESOURCE}/groups", options, Vimeo::Entities::Group)
      end

      ##
      # Get a list of videos in the users feed
      def feed options = {}
        perform_get_with_object("#{USER_RESOURCE}/feed", options, Vimeo::Entities::Video)
      end

      ##
      # Get a list of the user's followers.
      def followers
        perform_get_with_object("#{USER_RESOURCE}/followers", options, Vimeo::Entities::User)
      end

      ##
      # Get a list of the users that a user is following.
      def following
        perform_get_with_object("#{USER_RESOURCE}/following", options, Vimeo::Entities::User)
      end
    end
  end
end