module Vimeo
  module Entities
    class Group < Vimeo::Base
      include Vimeo::Helpers

      class << self
        ##
        # Create a new group
        def create client, options
          instance = new(client, options)
          instance.perform_post("/channels", options)
          instance
        end
      end

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
      # Delete a group
      def delete
        !!perform_delete("/groups/#{get_id}")
      end

      ##
      # Check if a Group has a video.
      def has_video? video_id
        !!perform_get("/groups/#{get_id}/videos/#{video_id}")
      end

      ##
      # Add a video to a Group.
      def add_video video_id
        !!perform_put("/groups/#{get_id}/videos/#{video_id}")
      end

      ##
      # Remove a video from a Group.
      def remove_video video_id
        !!perform_delete("/groups/#{get_id}/videos/#{video_id}")
      end
    end
  end
end