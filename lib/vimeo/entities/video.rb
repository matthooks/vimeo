module Vimeo
  module Entities
    class Video < Vimeo::Base
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
      end
    end
  end
end
