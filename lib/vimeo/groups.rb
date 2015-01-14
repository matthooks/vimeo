module Vimeo
  module Groups
    def groups options = {}
      get_request_with_object("/channels.json", options, Vimeo::Entities::Category)
    end

    def group id, options = {}
      get_request_with_object("/channels/#{id}.json", options, Vimeo::Entities::Category)
    end
  end
end