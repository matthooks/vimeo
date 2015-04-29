module Vimeo
  module Entities
    class User < Vimeo::Base
      include Vimeo::Helpers

      def update attributes = {}
        perform_path("/users/#{get_id}", attributes)
      end

      ##
      # Get a list of a users albumns
      def albums options = {}
        perform_get("/users/#{get_id}/albumns", options)
      end

      ##
      # Create an Album.
      def create_album attributes = {}
        perform_post("/users/#{get_id}/albumns", attributes)
      end

      ##
      # Get info on an Album.
      def album album_id
        perform_get("/users/#{get_id}/albums/#{album_id}")
      end

      ##
      # Edit an Album.
      def edit_album album_id, attributes = {}
        perform_path("/users/#{get_id}/albumns/#{album_id}", attributes)
      end

      ##
      # Delete an Album.
      def delete_album album_id
        perform_delete("/users/#{get_id}/albumns/#{album_id}")
      end

      ##
      # Get the list of videos in an Album.
      def album_videos album_id, options = {}
        perform_get_with_object("/users/#{get_id}/albums/#{album_id}/videos", options, Vimeo::Entities::Video)
      end

      ##
      # Check if an Album contains a video.
      def album_has_video? album_id, video_id
        perform_get("/users/#{get_id}/albums/#{album_id}/videos/#{video_id}")
      end

      ##
      # Add a video to an Album.
      def add_video_to_album album_id, video_id
        perform_put("/users/#{get_id}/albums/#{album_id}/videos/#{video_id}")
      end

      ##
      # Remove a video from an Album.
      def remove_video_from_album album_id, video_id
        perform_delete("/users/#{get_id}/albumns/#{album_id}/videos/#{video_id}")
      end

      ##
      # Get all videos the user appears in
      def appearances options = {}
        perform_get_with_object("/users/#{get_id}/appearances", options, Vimeo::Entities::Video)
      end

      ##
      # The the list of channels a user follows
      def channels options = {}
        perform_get_with_object("/users/#{get_id}/channels", options, Vimeo::Entities::Group)
      end

      ##
      # Check if a user follows a Channel.
      def belongs_to_channel? channel_id
        perform_get("/users/#{get_id}/channels/#{channel_id}")
      end

      ##
      # Subscribe to a Channel.
      def subscribe_to_channel channel_id
        perform_put("/users/#{get_id}/channels/#{channel_id}")
      end

      ##
      # Unsubscribe from a Channel.
      def unsubsribe_from_channel channel_id
        perfrom_delete("/users/#{get_id}/channel/#{channel_id}")
      end

      ##
      # Get a list of the groups a user has joined
      def groups options ={}
        perform_get_with_object("/users/#{get_id}/groups", options, Vimeo::Entities::Group)
      end

      ##
      # Check if a user has joined a Group?
      def belongs_to_group? group_id
        perform_get("/users/#{get_id}/groups/#{group_id}")
      end

      ##
      # Join a Group.
      def join_group group_id
        perform_put("/users/#{get_id}/groups/#{group_id}")
      end

      ##
      # Leave a Group.
      def leave_group group_id
        perform_delete("/users/#{get_id}/groups/#{group_id}")
      end

      ##
      # Get a list of videos in the users feed
      def feed options = {}
        perform_get_with_object("/users/#{get_id}/feed", options, Vimeo::Entities::Video)
      end

      ##
      # Get a list of the user's followers.
      def followers
        perform_get_with_object("/users/#{get_id}/followers", options, Vimeo::Entities::User)
      end

      ##
      # Check if a user follows another user.
      def follows? user_id
        perform_get("/users/#{get_id}/following/#{user_id}")
      end

      ##
      # Follow a user.
      def follow user_id
        perform_put("/users/#{get_id}/following/#{user_id}")
      end

      ##
      # Unfollow a user.
      def unfollow user_id
        perform_delete("/users/#{get_id}/following/#{user_id}")
      end

      ##
      # Get a list of videos that a user likes.
      def likes options = {}
        perform_get_with_object("/users/#{get_id}/likes", options, Vimeo::Entities::Video)
      end

      ## 
      # Check if a user likes a video.
      def likes_video? video_id
        perform_get("/users/#{get_id}/likes/#{video_id}")
      end

      ##
      # Like a video.
      def like_video video_id
        perform_put("/users/#{get_id}/likes/#{video_id}")
      end

      ##
      # Unlike a video.
      def unlike_video video_id
        perform_delete("/users/#{get_id}/likes/#{video_id}")
      end

      ##
      # Get a list of this user's portrait images.
      def pictures
        perform_get("/users/#{get_id}/pictures")
      end

      ##
      # Create a new picture resource.
      def create_picture
        perform_post("/users/#{get_id}/pictures")
      end

      ##
      # Check if a user has a portrait.
      def has_picture? picture_id
        perform_get("/users/#{get_id}/pictures/#{picture_id}")
      end

      ##
      # Edit a portrait.
      def edit_picture picture_id, options = {}
        perform_patch("/users/#{get_id}/pictures/#{picture_id}", options)
      end

      ##
      # Get a list of Portfolios created by a user.
      def portfolios options = {}
        perform_get("/users/#{get_id}/portfolios")
      end

      ##
      # Get a Portfolio.
      def portfolio portfolio_id, options = {}
        perform_get("/users/#{get_id}/portfolios/#{portfolio_id}")
      end

      ##
      # Get the videos in this Portfolio.
      def portfilio_videos portfolio_id, options = {}
        perform_get("/users/#{get_id}/portfolios/#{portfolio_id}/videos")
      end

      ##
      # Check if a Portfolio contains a video.
      def portfolio_has_video? portfolio_id, video_id
        perform_get("/users/#{get_id}/portfolios/#{portfolio_id}/videos/#{video_id}")
      end

      ##
      # Add a video to the Portfolio
      def add_video_to_portfolio portfolio_id, video_id
        perform_put("/users/#{get_id}/portfolio/#{portfolio_id}/videos/#{video_id}")
      end

      ##
      # Remove a video from the Portfolio.
      def remove_video_from_portfolio portfolio_id, video_id
        perform_delete("/users/#{get_id}/portfoilio/#{portfolio_id}/videos/#{video_id}")
      end

      ##
      # Get all presets created by the authenticated user.
      def presets options = {}
        perform_get("/users/#{get_id}/presets")
      end

      ##
      # Get a preset.
      def preset preset_id
        perform_get("/users/#{get_id}/presets/#{preset_id}")
      end

      ##
      # Edit a preset.
      def edit_preset preset_id, attributes
        perform_patch("/usres/#{get_id}/presets/#{preset_id}")
      end

      ##
      # Get videos that have the provided preset.
      def preset_videos preset_id
        perform_get("/users/#{get_id}/presets/#{preset_id}/videos")
      end
  
      ##
      # Get a list of videos uploaded by a user.
      def videos options = {}
        perform_get("/users/#{get_id}/videos", options)
      end

      ##
      # Get a list of the users that a user is following.
      def following
        perform_get_with_object("/users/#{get_id}/following", options, Vimeo::Entities::User)
      end
    end
  end
end
