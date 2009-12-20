module Vimeo
  module Advanced
    class Contact < Vimeo::Advanced::Base

      # Returns a list of a user's contacts.
      create_api_method :get_all,
                        "vimeo.contacts.getAll",
                        :required => [:user_id],
                        :optional => [:page, :per_page, :sort]

      # Returns a list of your mutual contacts with a user.
      create_api_method :get_mutual,
                        "vimeo.contacts.getMutual",
                        :required => [:user_id],
                        :optional => [:page, :per_page]

      # Returns a list of your contacts who are online.
      create_api_method :get_online,
                        "vimeo.contacts.getOnline",
                        :optional => [:page, :per_page]
      
      # Returns a list of users who added a user as a contact.
      create_api_method :get_who_added,
                        "vimeo.contacts.getWhoAdded",
                        :required => [:user_id],
                        :optional => [:page, :per_page, :sort]

    end # Contact
  end # Advanced
end # Vimeo