module Vimeo
  module Advanced
    class Person < Vimeo::Advanced::Base

      # Adds a user to your contact list.
      create_api_method :add_contact,
                        "vimeo.people.addContact",
                        :required => [:user_id]
                        
      # Adds a subscription to your subscriptions.
      # Types is a comma-delimited string. Valid options: "likes", "appears", "uploads"
      create_api_method :add_subscription,
                        "vimeo.people.addSubscription",
                        :required => [:user_id, :types]

      # Finds a user by their e-mail.
      create_api_method :find_by_email,
                        "vimeo.people.findByEmail",
                        :required => [:user_id]

      create_api_method :get_hd_embeds,
                        "vimeo.people.getHDEmbeds"

      # Returns a user's information
      create_api_method :get_info,
                        "vimeo.people.getInfo",
                        :required => [:user_id]
      
      # Returns a user's portrait URLs.
      create_api_method :get_portrait_urls,
                        "vimeo.people.getPortraitUrls",
                        :required => [:user_id]
      
      # Removes a user from your contact list.
      create_api_method :remove_contact,
                        "vimeo.people.removeContact",
                        :required => [:user_id]
      
      # Removes a subscription to your subscriptions.
      # Types is a comma-delimited string. Valid options: "likes", "appears", "uploads"
      create_api_method :remove_subscription,
                        "vimeo.people.removeSubscription",
                        :required => [:user_id, :types]

    end # Person
  end # Advanced
end # Vimeo