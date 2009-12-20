module Vimeo
  module Advanced
    class Channel < Vimeo::Advanced::Base

      # Adds a video to a channel.
      create_api_method :add_video,
                        "vimeo.channels.addVideo",
                        :required => [:channel_id, :video_id]
                        
      # Returns a list of all channels.
      create_api_method :get_all,
                        "vimeo.channels.getAll",
                        :optional => [:page, :per_page, :sort, :user_id]

      # Returns information about a channel.
      create_api_method :get_info,
                        "vimeo.channels.getInfo",
                        :required => [:channel_id]
      
      # Returns a list of the moderators of a channel.
      create_api_method :get_moderators,
                        "vimeo.channels.getModerators",
                        :required => [:channel_id],
                        :optional => [:page, :per_page]
      
      # Returns a list of the subscribers of a channel.
      create_api_method :get_subscribers,
                        "vimeo.channels.getSubscribers",
                        :required => [:channel_id],
                        :optional => [:page, :per_page]
                        
      # Returns a list of the videos in a channel.
      create_api_method :get_videos,
                        "vimeo.channels.getVideos",
                        :required => [:channel_id],
                        :optional => [:page, :per_page, :full_response]
                        
      # Removes a video from a channel.
      create_api_method :remove_video,
                        "vimeo.channels.removeVideo",
                        :required => [:channel_id, :video_id]
      
      # Subscribes to a channel
      create_api_method :subscribe,
                        "vimeo.channels.subscribe",
                        :required => [:channel_id]
      
      # Unsubscribes from a channel
      create_api_method :unsubscribe,
                        "vimeo.channels.unsubscribe",
                        :required => [:channel_id]

    end # Channel
  end # Advanced
end # Vimeo