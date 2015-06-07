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
      #
      # *album_id:* an album's unique id
      def album album_id
        perform_get("/me/albums/#{album_id}", {})
      end

      ##
      # Edit an album
      #
      # *album_id:* the album's unique id
      # *attributes:* a hash of attributes to update
      #
      # === Attributes
      # [name]
      #   (string) The Album's new title
      # [description]
      #   (string) The Album's new description
      # [privacy]
      #   (string) The Album's new privacy level
      #   * anybody
      #   * password
      # [sort]
      #   (string) The new default sort for the Album
      #   * arranged
      #   * newest
      #   * oldest
      #   * plays
      #   * comments
      #   * likes
      #   * added_first
      #   * added_last
      #   * alphabetical
      def edit_album album_id, attributes
        perform_patch("/me/albums/#{album_id}", attributes)
      end

      ##
      # Delete an Album.
      #
      # *album_id:* an album's unique id
      def delete_album album_id
        perform_delete("/me/albums/#{album_id}")
      end

      ##
      # Get a list of videos in an album
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
      #   * manual
      #   * date
      #   * alphabetical
      #   * plays
      #   * likes
      #   * comments
      #   * duration
      #   * modified_time
      # [direction]
      #   (string) The direction that the results are sorted.
      #   * asc
      #   * desc
      def album_videos options = {}
        perform_get_with_object("/me/albums/#{album_id}/videos", options, Vimeo::Entities::Video)
      end

      ##
      # Check if albumn has a video
      #
      # *album_id:* a albumn's unique id
      # *video_id:* a video's unique id
      def album_has_video? album_id, video_id
        perform_get("/me/albums/#{album_id}/videos/#{video_id}", {})
      end

      ##
      # Add a video to an album
      #
      # *album_id:* an albumn's unique id
      # *video_id:* a video's unique id
      def add_video_to_album album_id, video_id
        perform_put("/me/albums/#{album_id}/videos/#{video_id}")
      end

      ##
      # Remove a video from an album
      #
      # *album_id:* an albumn's unique id
      # *video_id:* a video's unique id
      def remove_video_from_album album_id, video_id
        perform_delete("/me/albums/#{album_id}/videos/#{video_id}")
      end

      ##
      # Get a list of videos the user appears in
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
      def appearances options = {}
        perform_get("/me/appearances", options)
      end

      ##
      # Get a list of channels the user follows
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
      #   * videos
      #   * followers
      # [direction]
      #   (string) The direction that the results are sorted.
      #   * asc
      #   * desc
      def channels options = {}
        perform_get_with_object("/me/channels", options, Vimeo::Entities::Channel)
      end

      ##
      # Check if the user follows a channel
      #
      # *channel_id:* a channel's unique id
      def subscribe_to_chanel channel_id
        perform_put("/me/channels/#{channel_id}")
      end

      ##
      # Ubsubscribe the user from a channel
      #
      # *channel_id:* a channel's unique id
      def unsubscribe_from_channel channel_id
        perform_delete("/me/channels/#{channel_id}")
      end

      ##
      # Get a list of the Groups a user has joined.
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
      #   * videos
      #   * memebers
      # [direction]
      #   (string) The direction that the results are sorted.
      #   * asc
      #   * desc
      def groups options = {}
        perform_get_with_object("/me/groups", options, Vimeo::Entities::Group)
      end

      ##
      # Check if the user has joined a group
      #
      # *group_id* a gorup's unique id
      def joined_group? group_id
        perform_get("/me/groups/#{group_id}", {})
      end

      ##
      # Join the user to a group
      #
      # *group_id:* a group's unique id
      def join_group group_id
        perform_put("/me/groups/#{group_id}")
      end

      ##
      # Remove a user grom a group
      #
      # *group_id:* a group's unique id
      def leave_group group_id
        perform_delete("/me/groups/#{group_id}")
      end

      ##
      # Get a list of videos in the users feed
      #
      # *options:* a hash of options to filter the feed
      #
      # === options
      # [page]
      #   (integer) The page number to show.
      # [per_page]
      #   (integer) Number of items to show on each page. Max 50.
      # [offset]
      #   (required) (string) This is necessary for proper pagination. Do not provide this value yourself, just use the pagination links provided in the feed response
      def feed options = {}
        perform_get_with_object("/me/feed", options, Vimeo::Entities::Video)
      end

      ##
      # Get a list of users who follow the user
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
      def followers options = {}
        perform_get_with_object("/me/followers", options, Vimeo::Entities::User)
      end

      ##
      # Get a list of users the user follows
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
      #   * online
      def following options ={}
        perform_get_with_object("/me/following", options , Vimeo::Entities::User)
      end

      ##
      # Check if the user follows another user.
      #
      # *user_id:* an user's unique id
      def following? user_id
        perform_get("/me/following/#{user_id}", {})
      end

      ##
      # Follow a user
      #
      # *user_id:* an user's unique id
      def follow user_id
        perform_put("/me/following/#{user_id}")
      end

      ##
      # Unfollow a user
      #
      # *user_id:* an user's unique id
      def unfollow user_id
        perform_delete("/me/following/#{get_id}")
      end

      ##
      # Get a list of videos the user likes
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
      # [filter]
      #   (string) Filter to apply to the results.
      #   * embeddable
      # [filter_embeddable]
      #   (string) Required if filter=embeddable. Choose between only videos that are embeddable, and only videos that are not embeddable.
      #   * true
      #   * false
      def likes options = {}
        perform_get_with_object("/me/likes", options, Vimeo::Entities::Video)
      end

      ##
      # Check if a user likes a video
      #
      # *video_id:* a video's unique id
      def likes? video_id
        perform_get("/me/likes/#{video_id}", {})
      end

      ##
      # Like a video
      #
      # *video_id:* a video's unique id
      def like video_id
        perform_put("/me/likes/#{video_id}")
      end

      ##
      # Ulike a video
      #
      # *video_Id:* a video's unique id
      def unlike video_id
        perform_delete("/me/likes/#{video_id}")
      end

      ##
      # Get a list of this user's portrait images.
      def pictures
        perform_get("/me/pictures", {})
      end

      # TODO: create/show/edit picture

      ##
      # Get a list of portfolios created by the user
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
      def portfolios options = {}
        perform_get("/me/portfolios", options)
      end

      ##
      # Get a portfolio
      #
      # *portfolio_id:* a portfolio's unique id
      def portfolio portfolio_id
        perform_get("/me/portfolios/#{portfolio_id}", {})
      end

      ##
      # Get a list of videos in a portfolio
      #
      # *options:* a hash of search options
      #
      # === options
      # [page]
      #   (integer) The page number to show.
      # [per_page]
      #   (integer) Number of items to show on each page. Max 50.
      # [sort]
      #   (string) Technique used to sort the results.
      #   * date
      #   * alphabetical
      #   * plays
      #   * likes
      #   * comments
      #   * manual
      #   * default
      # [direction]
      #   (string) The direction that the results are sorted.
      #   * asc
      #   * desc
      def portfolio_videos portfolio_id, options = {}
        perform_get_with_object("/me/portfolios/#{portfolio_id}/videos", options, Vimeo::Entities::Video)
      end

      ##
      # Check if a portfolio has a video
      #
      # *portfolio_id:* a portfolio's unique id
      # *video_id:* a portfolios unique id
      def portfolio_has_video portfolio_id, video_id
        perform_get("/me/portfolios/#{portfolio_id}/videos/#{video_id}", {})
      end

      ##
      # Add a video to a portfilio
      #
      # *portfolio:* a portfilio's unique id
      # *video_id:* a video's unique id
      def add_video_to_portfolio portfolio_id, video_id
        perform_put("/me/portfolios/#{portfolio_id}/videos/#{video_id}")
      end

      ##
      # Remove a video from a portfolio
      #
      # *portfolio:* a portfilio's unique id
      # *video_id:* a video's unique id
      def remove_video_from_portfolio portfolio_id, video_id
        perform_delete("/me/portfolios/#{portfolio_id}/videos/#{video_id}")
      end

      ##
      # Get a list of presets created by the user
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
      def presets options = {}
        perform_get("/me/presets", options)
      end

      ##
      # Get a preset
      #
      # *preset_id* a preset's unique id
      def preset preset_id
        perform_get("/me/presets/#{preset_id}")
      end

      ##
      # Update a preset
      #
      # *preset_id:* a preset's unique id
      # *attributes* a hash of the presets attributes to be updated
      #
      # === Attributes
      # [outro]
      #  (string) Disable the outro. Currently we only support disabling outros, let us know if you need additional features!
      #   * nothing
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
