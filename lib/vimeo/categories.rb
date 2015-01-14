module Vimeo
  module Categories
    include Vimeo::Helpers

    def categories options = {}
      perform_get_with_object("/categories.json", options, Vimeo::Entities::Category)
    end

    def category id, options = {}
      perform_get_with_object("/categories/#{id}.json", options, Vimeo::Entities::Category)
    end
  end
end