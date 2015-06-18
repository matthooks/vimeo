module Vimeo
  module Endpoints
    module Channels
      include Vimeo::Helpers

      ##
      # Get a list of all Channels
      #
      # *options:* a has of search options
      #
      # === options
      # [page]
      #  (integer) The page number to show.
      # [per_page]
      #  (integer) Number of items to show on each page. Max 50.
      # [query]
      #  (string) Search query.
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
      def channels options = {}
        perform_get_with_object("/channels", options, Vimeo::Entities::Channel)
      end

      ##
      # Get a Channel
      #
      # *channel_id:* the channel's unique id
      def channel channel_id
        perform_get_with_object("/channels/#{channel_id}", {}, Vimeo::Entities::Channel)
      end
    end
  end
end