module Vimeo
  module Tags
    include Vimeo::Helpers

    def tags word, options = {}
      perform_get_with_object("/tags/#{word}", options, Vimeo::Entities::Tag)
    end
  end
end