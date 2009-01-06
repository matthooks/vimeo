module Vimeo
  module Simple

    class Group < Vimeo::Simple::Base
      # Returns this group's clips.
      def self.clips(groupname)
        get("/group/#{groupname}/clips.json")
      end

      # Returns this group's users.
      def self.users(groupname)
        get("/group/#{groupname}/users.json")
      end

      # Returns this group's information.
      def self.info(groupname)
        get("/group/#{groupname}/info.json")
      end
    end

  end # Simple
end # Vimeo