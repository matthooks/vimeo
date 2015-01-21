module Vimeo
  module Categories
    include Vimeo::Helpers

    def categories options = {}
      perform_get_with_object("/categories", options, Vimeo::Entities::Category)
    end

    def category id, options = {}
      perform_get_with_object("/categories/#{id}", options, Vimeo::Entities::Category)
    end
  end
end