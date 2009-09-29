module Vimeo
  module Simple

    class Group < Vimeo::Simple::Base
      # Returns a list of a group's videos.
      #
      # @param [String] group_name The groups's name.
      def self.videos(groupname)
        get("/group/#{groupname}/videos.json")
      end

      # Returns a list of a group's users.
      #
      # @param [String] group_name The groups's name.
      def self.users(groupname)
        get("/group/#{groupname}/users.json")
      end

      # Returns a group's metadata.
      #
      # @param [String] group_name The groups's name.
      def self.info(groupname)
        get("/group/#{groupname}/info.json")
      end
    end

  end # Simple
end # Vimeo