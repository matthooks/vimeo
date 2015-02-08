module Vimeo
  module Entities
    class Channel < Vimeo::Base
      include Vimeo::Helpers

      ##
      # Get a list of the users who follow the channel
      def users options = {}
        perform_get_with_object("/channels/#{get_id}/users", options, Vimeo::Entities::User)
      end

      ##
      # Get a list of videos in the channel
      def videos options = {}
        perform_get_with_object("/channels/#{get_id}/videos", options, Vimeo::Entities::Video)
      end

      ##
      # Edit a channel's information
      def update
      end

      ##
      # Create a new channel
      def create
      end

      ##
      # Delete a channel
      def delete
      end

      private
      def get_id
        id || uri.match(/(\d+)/)[0]
      end
    end
  end
end