require 'pry'

module Vimeo
  module Simple

    class Video < Vimeo::Simple::Base
      # Returns this video's information.
      #
      # @param [String] video_id The video's id.
      def self.info(video_id)
        get("/oembed.json?url=https%3A//vimeo.com/#{video_id}")
      end
    end

  end # End Simple
end # End Vimeo