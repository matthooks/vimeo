module Vimeo
  module Endpoints
    module Categories
      include Vimeo::Helpers

      ##
      # Get a list of the top level categories
      #
      # *options:* a hash of serach options
      #
      # === options
      # [page]
      #   (integer) The page number to show.
      # [per_page]
      #   (integer) Number of items to show on each page. Max 50.
      def categories options = {}
        perform_get_with_object("/categories", options, Vimeo::Entities::Category)
      end

      ##
      # Get a category
      #
      # *category_id:* the category's unique identifer (typically the name). ie: animation
      def category category_id
        perform_get_with_object("/categories/#{category_id}", {}, Vimeo::Entities::Category)
      end
    end
  end
end