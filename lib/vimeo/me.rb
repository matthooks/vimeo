module Vimeo
  module Me
    include Vimeo::Helpers

    def me
      perform_get_with_object("/me", {}, Vimeo::Entities::User)
    end
  end
end