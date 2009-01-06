module Vimeo
  module Simple

    class Activity < Vimeo::Simple::Base
      def self.user_did(username)
        get("/activity/#{username}/user_did.json")
      end
    
      def self.happened_to_user(username)
        get("/activity/#{username}/happened_to_user.json")
      end
    
      def self.contacts_did(username)
        get("/activity/#{username}/contacts_did.json")
      end
    
      def self.happened_to_contacts(username)
        get("/activity/#{username}/happened_to_contacts.json")
      end
    
      def self.everyone_did(username)
        get("/activity/#{username}/everyone_did.json")
      end
    end

  end # Simple
end # Vimeo