module Vimeo
  module Entities
    ##
    # == Description
    # This provides an interface for the +group+ resource.
    class Group < Vimeo::Base
      include Vimeo::Helpers

      class << self
        ##
        # Create a new group
        #
        # *client:* an instance of vimeo client object
        # *attributes:* a hash of attributes
        # === attributes
        # [name]
        #   (required) (string) The name of the new Group
        #   (required) (string) The description of the new Group
        def create client, attributes
          instance = new(client, attributes)
          instance.perform_post("/channels", attributes)
          instance
        end
      end

      ##
      # Get a list of videos in a group
      #
      # *options:* a hash of search options
      #
      # === options
      # [page]
      #   (integer) The page number to show.
      # [per_page]
      #   (integer) Number of items to show on each page. Max 50.
      # [query]
      #   (string) Search query.
      # [filter]
      #   (string) Filter to apply to the results.
      #   * embeddable
      # [filter_embeddable]
      #   (string) Required if filter=embeddable. Choose between only videos that are embeddable, and only videos that are not embeddable.
      #   * true
      #   * false
      # [sort]
      #   (string) Technique used to sort the results.
      #   * date
      #   * alphabetical
      #   * plays
      #   * likes
      #   * comments
      #   * duration
      # [direction]
      #   (string) The direction that the results are sorted.
      #   * asc
      #   * desc
      def videos options = {}
        perform_get_with_object("/groups/#{get_id}/videos", options, Vimeo::Entities::Video)
      end

      ##
      # Get a list of users that have joined a group
      #
      # *options:* a hash of search options
      #
      # === options
      # [page]
      #   (integer) The page number to show.
      # [per_page]
      #   (integer) Number of items to show on each page. Max 50.
      # [query]
      #   (string) Search query.
      # [sort]
      #   (string) Technique used to sort the results.
      #   * date
      #   * alphabetical
      # [direction]
      #   (string) The direction that the results are sorted.
      #   * asc
      #   * desc
      # [filter]
      #   (string) Filter to apply to the results.
      #   * moderators
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
      #
      # *video_id:* the video's unique ID
      def has_video? video_id
        !!perform_get("/groups/#{get_id}/videos/#{video_id}")
      end

      ##
      # Add a video to a Group.
      #
      # *video_id:* the video's uniuqe ID
      def add_video video_id
        !!perform_put("/groups/#{get_id}/videos/#{video_id}")
      end

      ##
      # Remove a video from a Group.
      #
      # *video_id:* the video's unique ID
      def remove_video video_id
        !!perform_delete("/groups/#{get_id}/videos/#{video_id}")
      end
    end
  end
end