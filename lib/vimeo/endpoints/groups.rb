module Vimeo
  module Endpoints
    module Groups
      include Vimeo::Helpers

      ##
      # Get a list of all Groups
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