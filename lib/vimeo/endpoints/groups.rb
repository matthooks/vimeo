module Vimeo
  module Endpoints
    module Groups
      include Vimeo::Helpers

      ##
      # Get a list of all Groups
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
      #   * videos
      #   * followers
      # [direction]
      #   (string) The direction that the results are sorted.
      #   * asc
      #   * desc
      # [filter]
      #   (string) Filter to apply to the results.
      #   * featured
      def groups options = {}
        perform_get_with_object("/groups", options, Vimeo::Entities::Group)
      end

      ##
      # Get a Group
      def group id, options = {}
        perform_get_with_object("/groups/#{id}", options, Vimeo::Entities::Group)
      end
    end
  end
end