module Vimeo
  module Advanced
    class VideoEmbed < Vimeo::Advanced::Base

      # Returns a list of presets for a video embed.
      create_api_method :get_presets,
                        "vimeo.videos.embed.getPresets",
                        :optional => [:page, :per_page]

      # Sets a preset for a video embed.
      create_api_method :set_preset,
                        "vimeo.videos.embed.setPreset",
                        :required => [:video_id, :preset_id]

    end # VideoEmbed
  end # Advanced
end # Vimeo
