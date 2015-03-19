module Vimeo
  module Endpoints
    module Channels
      include Vimeo::Helpers

      ##
      # Get a list of all Channels
      def channels options = {}
        perform_get_with_object("/channels", options, Vimeo::Entities::Channel)
      end

      ##
      # Get a Channel
      def channel id, options = {}
        perform_get_with_object("/channels/#{id}", options, Vimeo::Entities::Channel)
      end
    end
  end
end