module Vimeo
  module Entities
    ##
    # === Description
    class Video < Vimeo::Base

      ##
      # Edit video metadata
      #
      # *attributes:* a hash of attributes to be updated
      # === Attributes
      # [name]
      #   (string) The new name for the video
      # [description]
      #   (string) The new description for the video
      # [license]
      #   (string) Set the Creative Commons license
      #   * by
      #   * by-sa
      #   * by-nd
      #   * by-nc
      #   * by-nc-sa
      #   * by-nc-nd
      #   * cc0
      # [privacy.view]
      #   (string) The new privacy setting for the video
      #   * anybody
      #   * nobody
      #   * contacts
      #   * password
      #   * disable
      # [password]
      #   (string) When you set privacy.view to password, you must provide the password as an additional parameter
      # [privacy.embed]
      #   (string) The videos new embed settings. Whitelist allows you to define all valid embed domains.
      # [review_link]
      #   (string) Enable or disable the review page
      # [locale]
      #   (string) Set the default language for this video. For a full list of valid languages use the "/languages?filter=texttracks" endpoint
      # [content_rating]
      #   (string) A list of values describing the content in this video. You can find the full list in the /contentrating endpoint. You must provide a list representation appropriate for your request body (comma separated for querystring, or array for JSON)
      # [embed]
      def edit attributes
        perform_patch("/videos/#{get_id}", attributes)
      end

      ##
      # Delete the video
      def delete
        perform_delete("/videos/#{get_id}", attributes)
      end


      ##
      # Relace a video's source file. Get an upload ticket to replace this video file.
      #
      # *options:* a hash of options to create a new upload ticket
      # === Options
      # [type]
      #   (string) Upload type
      #   * POST
      #   * streaming
      # [redirect_url]
      #   (string) The app redirect URL
      # [upgrade_to_1080]
      #   (string) Immediately upgrade to 1080p on upload complete.
      def replace options
        perform_put("/videos/#{get_id}", options)
      end

      ##
      # Get a list of users credited on a video.
      def credits
        perform_get("/videos/#{get_id}/credits")
      end

      ##
      # Add a credit to a video
      def add_credit attributes
        perform_post("/videos/#{get_id}/credits", attributes)
      end

      ##
      # Get all the text tracks for a video.
      def text_tracks
        perform_get("/videos/#{get_id}/texttracks")
      end

      ##
      # Add a text track to a video.
      def add_text_track attributes
        perform_post("/videos/#{get_id}/texttracks", attributes)
      end

      ##
      # Get a single text track for a video.
      def text_track track_id
        perfrom_get("/videos/#{get_id}/texttracks/#{track_id}")
      end

      ##
      # Edit text track metadata.
      def edit_text_track track_id, attributes
        perform_patch("/videos/#{get_id}/texttrack/#{track_id}", attributes)
      end

      ##
      # Delete a text track.
      def delete_text_track track_id
        perform_delete("/videos/#{get_id}/texttrack/#{track_id}")
      end

      ##
      # Get related videos.
      def related_videos options = {}
        perform_get_with_object("/videos/#{get_id}/videos", options, Vimeo::Entities::Video)
      end

      ##
      # Get a list of all categories this video is in.
      def categories options = {}
        perform_get_with_object("/videos/#{get_id}/categories", options, Vimeo::Entities::Category)
      end

      ##
      # Add up to 2 categories and 1 sub-category to a video.
      def add_categories category
        perform_put("/videos/#{get_id}/categories")
      end

      ##
      # Get credits
      def credits options = {}
        perform_get("/videos/#{get_id}/credits", options)
      end

      ##
      # Get a single credit
      def credit credit_id
        perform_get("/videos/#{get_id}/credits/#{credit_id}")
      end

      ##
      # Delete a credit
      def delete_credit credit_id
        perform_delete("/videos/#{get_id}/credits/#{credit_id}")
      end

      ##
      # Edit information about a single credit
      def edit_credit credit_id, attributes
        perform_patch("/videos/#{get_id}/credits/#{credit_id}", attributes)
      end

      ##
      # Get comments on this video.
      def comments options = {}
        perform_get("/videos/#{get_id}/comments", options)
      end

      ##
      # Post a comment on the video
      def post_comment attributes
        perform_post("/videos/#{get_id}/comments", attributes)
      end

      ##
      # Check if a video has a specific comment
      def has_comment? comment_id
        perform_get("/videos/#{get_id}/comments/#{comment_id}")
      end

      def edit_comment attributes
        perform_patch("/videos/#{get_id}/comments/#{comment_id}", attributes)
      end

      def delete_comment comment_id
        perform_delete("/videos/#{get_id}/comments/#{comment_id}")
      end

      def comment_replies comment_id
        perform_get("/videos/#{get_id}/comments/#{comment_id}/replies")
      end

      def reply_to_comment comment_id, attributes
        perform_post("/videos/#{get_id}/comments/#{comment_id}", attributes)
      end

      def pictures
        perform_get("/videos/#{get_id}/pictures")
      end

      def add_picture attributes
        perform_post("/videos/#{get_id}/pictures", pictures)
      end

      def picture picture_id
        perform_get("/videos/#{get_id}/pictures/#{picture_id}")
      end

      def modify_picture picture_id, attributes
        perform_patch("/videos/#{get_id}/pictures/#{picture_id}", attributes)
      end

      def delete_picture picture_id
        perform_delete("/videos/#{get_id}/pictures/#{picture_id}")
      end

      def likes options = {}
        perform_get("/videos/#{get_id}/likes", options)
      end

      def presets preset_id
        perform_get("/videos/#{get_id}/presets/#{preset_id}")
      end

      def tags
        perform_get("/videos/#{get_id}/tags")
      end

      def has_tag? word
        perform_get("/videos/#{get_id}/tags/#{word}")
      end

      def add_tag word
        perform_put("/videos/#{get_id}/tags/#{word}")
      end

      def delete_tag word
        perform_put("/videos/#{get_id}/tags/#{word}")
      end

      def users
        perform_get("/videos/#{get_id}/privacy/users")
      end

      def add_user user_id
        perform_put("/vidoes/#{get_id}/privacy/users/#{user_id}")
      end

      def remove_user user_id
        perform_delete("/videos/#{get_id}/privacy/users/#{user_id}")
      end

      def embed_domains embed_id
        perform_get("/videos/#{get_id}/privacy/domains/#{embed_id}")
      end

      def add_embed_domain domain
        perform_put("/videos/#{get_id}/privacy/domains/#{domain}")
      end

      def remove_embed_domain domain
        perform_delete("/videos/#{get_id}/privacy/domains/#{domain}")
      end
    end
  end
end
