module Vimeo
  module Entities
    class Category < Vimeo::Base

      ##
      # Get a list of channels related to this category
      def channels; end

      ##
      # Get a list of groups related to this category
      def groups; end

      ##
      # Get a list of users related to this category
      def users; end

      ##
      # Get a list of videos related to this category
      def videos; end
    end
  end
end