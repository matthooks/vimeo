module Vimeo
  module Advanced
    class GroupEvents < Vimeo::Advanced::Base

      # Returns a list of events from a group for a specific month.
      create_api_method :get_month,
                        "vimeo.groups.events.getMonth",
                        :required => [:group_id],
                        :optional => [:page, :per_page, :month, :year]

      # Returns a list of all past events from a group.
      create_api_method :get_past,
                        "vimeo.groups.events.getPast",
                        :required => [:group_id],
                        :optional => [:page, :per_page]
      
      # Returns a list of all upcoming events from a group.
      create_api_method :get_upcoming,
                        "vimeo.groups.events.getUpcoming",
                        :required => [:group_id],
                        :optional => [:page, :per_page]

    end # GroupEvents
  end # Advanced
end # Vimeo