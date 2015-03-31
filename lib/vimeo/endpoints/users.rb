module Vimeo
  module Endpoints
    module Users
      include Vimeo::Helpers

      ##
      # Search for users.
      def user user_id, options = {}
        perform_get_with_object("/users/#{user_id}", options, Vimeo::Entities::User)
      end
    end
  end
end