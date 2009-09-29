module Vimeo
  module Simple

    class Activity < Vimeo::Simple::Base
      # Returns a list of a user's activities.
      #
      # @param [String] username The user's id or username.
      def self.user_did(username)
        get("/activity/#{username}/user_did.json")
      end
    
      # Returns a list of activities that happened to a user.
      #
      # @param [String] username The user's id or username.
      def self.happened_to_user(username)
        get("/activity/#{username}/happened_to_user.json")
      end
    
      # Returns a list of activities a user's contact's did.
      #
      # @param [String] username The user's id or username.
      def self.contacts_did(username)
        get("/activity/#{username}/contacts_did.json")
      end
    
      # Returns a list of activities that happened to a user's contacts.
      #
      # @param [String] username The user's id or username.
      def self.happened_to_contacts(username)
        get("/activity/#{username}/happened_to_contacts.json")
      end
    
      # Returns a list of activities everyone did.
      #
      # @param [String] username The user's id or username.
      def self.everyone_did(username)
        get("/activity/#{username}/everyone_did.json")
      end
    end

  end # Simple
end # Vimeo