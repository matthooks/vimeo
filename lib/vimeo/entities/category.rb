module Vimeo
  module Entities
    class Category < Vimeo::Base
      include Vimeo::Helpers

      ##
      # Get a list of channels related to this category
      def channels options = {}
        perform_get_with_object("/categories/#{name}/channels", options, Vimeo::Entities::Channel)
      end

      ##
      # Get a list of groups related to this category
      def groups options = {}
        perform_get_with_object("/categories/#{name}/groups", options, Vimeo::Entities::Group)
      end

      ##
      # Get a list of users related to this category
      def users options = {}
        perform_get_with_object("/categories/#{name}/users", options, Vimeo::Entities::User)
      end

      ##
      # Get a list of videos related to this category
      def videos options = {}
        perform_get_with_object("/categories/#{name}/videos", options, Vimeo::Entities::Video)
      end

      ##
      # Check if a category contains a video
      def has_video? video_id
        perform_get_with_object("categories/#{name}/videos/#{video_id}", {}, Vimeo::Entities::Video)
      end
    end
  end
end