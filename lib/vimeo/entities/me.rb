module Vimeo
  module Entities
    ##
    # == Description
    # This provides an interface to the +me+ resource
    class Me < Vimeo::Base
      include Vimeo::Helpers

      ##
      # Update the user's profile
      #
      # *attributes:* a hash of user attributes to update
      #
      # === attributes
      # [name]
      #   (string) The user's display name
      # [location]
      #   (string) The user's location
      # [bio]
      #   (string) The user's bio
      def update attributes
        perform_patch("/me", attributes)
      end

      ##
      # Get a list of the user's albums
      #
      # *options:* a hash of search options
      #
      # === options
      # [page]
      #   (integer) The page number to show.
      # [per_page]
      #   (integer) Number of items to show on each page. Max 50.
      # [query]
      #   (integer) Search query.
      # [sort]
      #   (string) Technique used to sort the results.
      #   * date
      #   * alphabetical
      #   * videos
      #   * duration
      # [direction]
      #   (string) The direction that the results are sorted.
      #   * asc
      #   * desc
      def albums options = {}
        perform_get("/me/albums", options)
      end

      ##
      # Create a new album
      #
      # *attributes:* a hash of the albumns properties
      #
      # === attributes
      # [name]
      #   (string) The Album title
      # [description]
      #   (string) The Album description
      # [privacy]
      #   (string) The Album's privacy level
      # [password]
      #   (string) Required if privacy=password. The Album's password
      # [sort]
      #   (string) The default sort order of an Album's videos
      #   * arranged
      #   * newest
      #   * oldest
      #   * plays
      #   * comments
      #   * likes
      #   * added_first
      #   * added_last
      #   * alphabetical
      def create_album attributes
        perform_post("/me/albums", attributes)
      end

      ##
      # Get info on an album
      def album album_id
        perform_get("/me/albums/#{album_id}", {})
      end

      ##
      #
      def edit_album album_id, attributes
        perform_patch("/me/albums/#{album_id}", attributes)
      end

      def delete_album album_id
        perform_delete("/me/albums/#{album_id}")
      end

      def album_videos options = {}
        perform_get_with_object("/me/albums/#{album_id}/videos", options, Vimeo::Entities::Video)
      end

      def album_has_video? album_id, video_id
        perform_get("/me/albums/#{album_id}/videos/#{video_id}", {})
      end

      def add_video_to_album album_id, video_id
        perform_put("/me/albums/#{album_id}/videos/#{video_id}")
      end

      def remove_video_from_album album_id, video_id
        perform_delete("/me/albums/#{album_id}/videos/#{video_id}")
      end

      def appearances options = {}
        perform_get("/me/appearances", options)
      end

      def channels options = {}
        perform_get_with_object("/me/channels", options, Vimeo::Entities::Channel)
      end

      def subscribe_to_chanel channel_id
        perform_put("/me/channels/#{channel_id}")
      end

      def unsubscribe_from_channel channel_id
        perform_delete("/me/channels/#{channel_id}")
      end

      def groups options = {}
        perform_get_with_object("/me/groups", options, Vimeo::Entities::Group)
      end

      def joined_group? group_id
        perform_get("/me/groups/#{group_id}", {})
      end

      def join_group group_id
        perform_put("/me/groups/#{group_id}")
      end

      def leave_group group_id
        perform_delete("/me/groups/#{group_id}")
      end

      def feed options = {}
        perform_get_with_object("/me/feed", options, Vimeo::Entities::Video)
      end

      def followers options = {}
        perform_get_with_object("/me/followers", options, Vimeo::Entities::User)
      end

      def following options ={}
        perform_get_with_object("/me/following", options , Vimeo::Entities::User)
      end

      def following? user_id
        perform_get("/me/following/#{user_id}", {})
      end

      def follow user_id
        perform_put("/me/following/#{user_id}")
      end

      def unfollow user_id
        perform_delete("/me/following/#{get_id}")
      end

      def likes options = {}
        perform_get_with_object("/me/likes", options, Vimeo::Entities::Video)
      end

      def likes? video_id
        perform_get("/me/likes/#{video_id}", {})
      end

      def like video_id
        perform_put("/me/likes/#{video_id}")
      end

      def unlike video_id
        perform_delete("/me/likes/#{video_id}")
      end

      def pictures
        perform_get("/me/pictures", {})
      end

      def portfolios options = {}
        perform_get("/me/portfolios", options)
      end

      def portfolio portfolio_id
        perform_get("/me/portfolios/#{portfolio_id}", {})
      end

      def portfolio_videos portfolio_id, options = {}
        perform_get_with_object("/me/portfolios/#{portfolio_id}/videos", options, Vimeo::Entities::Video)
      end

      def portfolio_has_video portfolio_id, video_id
        perform_get("/me/portfolios/#{portfolio_id}/videos/#{video_id}", {})
      end

      def add_video_to_portfolio portfolio_id, video_id
        perform_put("/me/portfolios/#{portfolio_id}/videos/#{video_id}")
      end

      def remove_video_from_portfolio portfolio_id, video_id
        perform_delete("/me/portfolios/#{portfolio_id}/videos/#{video_id}")
      end

      def presets options = {}
        perform_get("/me/presets", options)
      end

      def preset preset_id
        perform_get("/me/presets/#{preset_id}")
      end

      def edit_preset preset_id, attributes
        perform_patch("/me/presets/#{preset_id}", attributes)
      end

      def preset_videos preset_id
        perform_get_with_object("/me/presets/#{preset_id}/videos", {}, Vimeo::Entities::Video)
      end

      def videos options = {}
        perform_get_with_object("/me/videos", options, Vimeo::Entities::Video)
      end

      def new_video attributes
        perform_post("/me/videos", attributes)
      end

      def has_video? video_id
        perform_get("/me/videos/#{video_id}", {})
      end

      def watch_later options = {}
        perform_get_with_object("/me/watchlater", options, Vimeo::Entities::Video)
      end

      def watch_later_has_video? video_id
        perform_get("/me/watchlater/#{video_id}", {})
      end

      def add_video_to_watch_later video_id
        perform_get("/me/watchlater/#{video_id}", {})
      end

      def remove_video_from_watch_later video_id
        perform_delete("/me/watchlater/#{video_id}", {})
      end

      def on_demand_pages options = {}
        perform_get("/me/ondemand/pages", options)
      end

      def create_on_demand_page attributes
        perform_post("/me/ondemand/pages", attributes)
      end

      def on_demand_library options = {}
        perform_get_with_object("/me/ondemand/library", options, Vimeo::Entities::Video)
      end

      def page_in_on_demand_library page_id
        perform_get("/me/ondemand/library/#{page_id}", {})
      end
    end
  end
end
