module Vimeo
  module Entities
    ##
    # == Description
    # This provides an interface for the +category+ resource.
    # With a category instance, you can fetch its sub-resources such as #videos, #groups and #channels assigned to it.
    #
    # Note that categories are read only.
    # == Usage
    # This class is typically initialized by the client when fetching a category with its _name_ such as:
    #  client = Vimeo::Client.new access_token: '1234'
    #  category = client.category 'animation' #=> <Vimeo::Entities::Category>
    #  category.videos #=> <Vimeo::Collection>
    # You can also initialize your own instance with its _name_ if you are for example, quickly after
    # the categories sub-resources
    #  client = Vimeo::Client.new access_token: '1234'
    #  category = Vimeo::Entities::Category.new client, name: 'animation' #=> Vimeo::Entities::Category
    #  category.videos #=> <Vimeo::Collection>
    # == More information
    # See {Vimeo documentation}[https://developer.vimeo.com/api/endpoints/categories]
    #
    class Category < Vimeo::Base
      include Vimeo::Helpers

      ##
      # Get a list of channels related to this category.
      # === options
      # [page]
      #  (int) The page number to show.
      # [per_page]
      #  (per_page) Number of items to show on each page. Max 50.
      # [query]
      #  (string) Search query.
      # [sort]
      #  (string) Technique used to sort the results.
      #  * date
      #  * alphabetical
      #  * videos
      #  * members
      # [direction]
      #  (string) The direction that the results are sorted.
      #  * asc
      #  * desc
      #
      # See {Vimeo documentation}[https://developer.vimeo.com/api/endpoints/categories#/{category}/channels]
      def channels options = {}
        perform_get_with_object("/categories/#{name}/channels", options, Vimeo::Entities::Channel)
      end

      ##
      # Get a list of groups related to this category
      # === options
      # [page]
      #  (int) The page number to show.
      # [per_page]
      #  (per_page) Number of items to show on each page. Max 50.
      # [query]
      #  (string) Search query.
      # [sort]
      #  (string) Technique used to sort the results.
      #  * date
      #  * alphabetical
      #  * videos
      #  * members
      # [direction]
      #  (string) The direction that the results are sorted.
      #  * asc
      #  * desc
      #
      # See {Vimeo documentation}[https://developer.vimeo.com/api/endpoints/categories#/{category}/groups]
      def groups options = {}
        perform_get_with_object("/categories/#{name}/groups", options, Vimeo::Entities::Group)
      end

      ##
      # Get a list of videos related to this category
      # === options
      # [page]
      #  (int) The page number to show.
      # [per_page]
      #  (per_page) Number of items to show on each page. Max 50.
      # [query]
      #  (string) Search query.
      # [filter]
      #  (string) Filter to apply to the results.
      #  * embeddable
      # [filter_embeddable]
      #  (string) Required if filter=embeddable. Choose between only videos that are embeddable, and only videos that are not embeddable.
      # [sort]
      #  (string) Technique used to sort the results.
      #  * relevant
      #  * date
      #  * alphabetical
      #  * plays
      #  * likes
      #  * comments
      #  * duration
      # [direction]
      #  (string) The direction that the results are sorted.
      #  * asc
      #  * desc
      #
      # See {Vimeo documentation}[https://developer.vimeo.com/api/endpoints/categories#/{category}/videos]
      def videos options = {}
        perform_get_with_object("/categories/#{name}/videos", options, Vimeo::Entities::Video)
      end

      ##
      # Check if a category contains a video
      #
      # See {Vimeo Documentation}[https://developer.vimeo.com/api/endpoints/categories#/{category}/videos/{video_id}]
      def has_video? video_id
        begin
          perform_get_with_object("categories/#{name}/videos/#{video_id}", {}, Vimeo::Entities::Video)
        rescue Vimeo::NotFound
          false
        end
      end
    end
  end
end