module Vimeo
  module Entities
    ##
    # == Description
    # This provides an interface for the +channel+ resource.
    # With a group instance, you can fetch its sub-resources such as #users and #videos.
    # You are able to create, update and remove channels
    # === Usage
    # This class is typically initialized by the client when fetching a channel
    # with its _id_ such as:
    #  client = Vimeo::Client.new access_token: '1234'
    #  channels = client.channels #=> <Vimeo::Channel>
    #  channel = channels.first #=> <Vimeo::Entities::Channel>
    #  channel.name #=> "Advertising"
    #
    # See {Vimeo documentation}[https://developer.vimeo.com/api/endpoints/channels]
    class Channel < Vimeo::Base
      include Vimeo::Helpers

      class << self
        ##
        # Create a new Channel.
        #
        # *attributes:* a hash of the channels properties
        # === attributes
        # [name]
        #  (required) (string) The name of the new Channel
        # [description]
        #  (required) (string) The description of the new Channel
        # [privacy]
        #  (required) (string) The privacy level of the new Channel
        #  * anybody
        #  * user
        def create client, attributes = {}
          instance = new(client, attributes)
          instance.perform_post("/channels", attributes)
          instance
        end
      end

      ##
      # Get a list of the users who follow the channel
      #
      # *options:* a has of search options
      # === options
      # [page]
      #  (int) The page number to show.
      # [per_page]
      #  (int) Number of items to show on each page. Max 50.
      # [query]
      #  (string) Search query.
      # [sort]
      #  (string) Technique used to sort the results.
      #  * date
      #  * alphabetical
      # [direction]
      #  (string) The direction that the results are sorted.
      #  * asc
      #  * desc
      # [filter]
      #  (string) Filter to apply to the results.
      #  * moderators
      def users options = {}
        perform_get_with_object("/channels/#{get_id}/users", options, Vimeo::Entities::User)
      end

      ##
      # Get a list of videos in the channel
      #
      # *options:* a hash of search options
      # === options
      # [page]
      #  (int) The page number to show.
      # [per_page]
      #  (int) Number of items to show on each page. Max 50.
      # [query]
      #  (string) Search query.
      # [filter]
      #  (string) Filter to apply to the results.
      # [filter_embeddable]
      #  (string) Required if filter=embeddable. Choose between only videos that are embeddable, and only videos that are not embeddable.
      #  * true
      #  * false
      # [sort]
      #  (string) Technique used to sort the results.
      #  * date
      #  * alphabetical
      #  * plays
      #  * likes
      #  * comments
      #  * duration
      #  * added
      #  * modified_time
      # [direction]
      #  (string) The direction that the results are sorted.
      #  * asc
      #  * desc
      def videos options = {}
        perform_get_with_object("/channels/#{get_id}/videos", options, Vimeo::Entities::Video)
      end

      ##
      # Edit a channel's information
      #
      # *attributes:* a hash of the channels properties
      # === attributes
      # [name]
      #  (string) The Channel's new name
      # [description]
      #  (string) The Channel's new description
      # [privacy]
      #  (string) The Channel's new privacy level
      #  * anybody
      #  * users
      def update attributes
        perform_patch("/channels/#{get_id}", attributes)
      end

      ##
      # Delete a channel
      def delete
        !!perform_delete("/channels/#{get_id}")
      end

      ##
      # Check if the channel contains a video.
      #
      # *videos_id:* The video's ID
      def has_video? video_id
        !!perform_get("/channels/#{get_id}/videos/#{video_id}")
      end

      ##
      # Add a video to a Channel
      #
      # *video_id:* The video's ID
      def add_video video_id
        !!perform_put("/channels/#{get_id}/videos/#{video_id}")
      end

      ##
      # Remove a video from a Channel
      #
      # *video_id:* the video's ID
      def remove_video video_id
        !!perform_delete("/channels/#{channel_id}/videos/#{video_id}")
      end
    end
  end
end
