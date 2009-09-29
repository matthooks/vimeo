module Vimeo
  module Advanced
    class VideoEmbed < Vimeo::Advanced::Base

      # Returns a list of presets for a video embed.
      # FIXME: Needs a page optional as well...?
      create_api_method :get_presets,
                        "vimeo.video.embed.getPresets",
                        :required => [:auth_token],
                        :optional => [:page, :per_page]

      # Sets a preset for a video embed.
      create_api_method :set_preset,
                        "vimeo.video.embed.setPreset",
                        :required => [:auth_token, :video_id, :preset_id]

    end # VideoEmbed
  end # Advanced
end # Vimeo