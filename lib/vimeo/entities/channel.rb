module Vimeo
  module Entities
    class Channel < Vimeo::Base
      include Vimeo::Helpers

      class << self
        def create client, options = {}
          instance = new(client, options)
          instance.perform_post("/channels", options)
          instance
        end
      end

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
      def update options = {}
        perform_post("/channels/#{get_id}", options)
      end

      ##
      # Delete a channel
      def delete
        !!perform_delete("/channels/#{get_id}")
      end
    end
  end
end