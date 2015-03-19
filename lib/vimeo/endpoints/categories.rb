module Vimeo
  module Endpoints
    module Categories
      include Vimeo::Helpers

      ##
      # Get a list of the top level categories
      def categories options = {}
        perform_get_with_object("/categories", options, Vimeo::Entities::Category)
      end

      ##
      # Get a category
      def category id, options = {}
        perform_get_with_object("/categories/#{id}", options, Vimeo::Entities::Category)
      end
    end
  end
end