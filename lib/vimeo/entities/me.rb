module Vimeo
  module Entities
    class Me < Vimeo::User
      def USER_RESOURCE
        "/me"
      end
    end
  end
end