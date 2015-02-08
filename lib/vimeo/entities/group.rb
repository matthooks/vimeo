module Vimeo
  module Entities
    class Group < Vimeo::Base
      include Vimeo::Helpers

      ##
      # Get a list of videos in a group
      def videos options = {}
        perform_get_with_object("/groups/#{get_id}/videos", options, Vimeo::Entities::Video)
      end

      ##
      # Get a list of users that have joined a group
      def users options = {}
        perform_get_with_object("/groups/#{get_id}/users", options, Vimeo::Entities::User)
      end

      ##
      # Create a new group
      def create
      end

      ##
      # Delete a group
      def delete
      end
    end
  end
end