module Vimeo
  module Endpoints
    module Channels
      include Vimeo::Helpers

      def channels options = {}
        perform_get_with_object("/channels", options, Vimeo::Entities::Channel)
      end

      def channel id, options = {}
        perform_get_with_object("/channels/#{id}", options, Vimeo::Entities::Channel)
      end
    end
  end
end