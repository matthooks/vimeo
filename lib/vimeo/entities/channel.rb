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
      def update options
        perform_patch("/channels/#{get_id}", options)
      end

      ##
      # Delete a channel
      def delete
        !!perform_delete("/channels/#{get_id}", )
      end

      ##
      # Check if the channel contains a video.
      def has_video? video_id
        !!perform_get("/channels/#{get_id}/videos/#{video_id}")
      end

      ##
      # Add a video to a Channel
      def add_video video_id
        !!perform_put("/channels/#{get_id}/videos/#{video_id}")
      end

      ##
      # Remove a video from a Channel
      def remove_video video_id
        !!perform_delete("/channels/#{channel_id}/videos/#{video_id}")
      end
    end
  end
end