module Vimeo
  module Endpoints
    module Users
      include Vimeo::Helpers

      ##
      # Search for users.
      #
      # *options:* a hash of search options
      #
      # === options
      # [page]
      #   (intger) The page number to show.
      # [per_page]
      #   (integer) Number of items to show on each page. Max 50.
      # [query]
      #   (string) Search query.
      # [sort]
      #   (string) Technique used to sort the results.
      #   * relevent
      #   * date
      #   * alphabetical
      # [direction]
      #   (string) The direction that the results are sorted.
      #   * asc
      #   * desc
      def user user_id, options = {}
        perform_get_with_object("/users/#{user_id}", options, Vimeo::Entities::User)
      end
    end
  end
end