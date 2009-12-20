module Vimeo
  module Advanced
    class Group < Vimeo::Advanced::Base

      # Adds a video to a group.
      create_api_method :add_video,
                        "vimeo.groups.addVideo",
                        :required => [:group_id, :video_id]

      # Returns a list of all groups.
      create_api_method :get_all,
                        "vimeo.groups.getAll",
                        :optional => [:page, :per_page, :sort, :user_id]
      
      # Returns a list of a group's files.
      create_api_method :get_files,
                        "vimeo.groups.getFiles",
                        :required => [:group_id],
                        :optional => [:page, :per_page]

      # Returns information about a group.
      create_api_method :get_info,
                        "vimeo.groups.getInfo",
                        :required => [:group_id]

      # Returns a list of the members in a group.
      create_api_method :get_members,
                        "vimeo.groups.getMembers",
                        :required => [:group_id],
                        :optional => [:page, :per_page, :sort]
      
      # Returns a list of the moderators of a group.
      create_api_method :get_moderators,
                        "vimeo.groups.getModerators",
                        :required => [:group_id],
                        :optional => [:page, :per_page]

      # Returns a list of the comments on a video in a group.
      create_api_method :get_video_comments,
                        "vimeo.groups.getVideoComments",
                        :required => [:group_id, :video_id],
                        :optional => [:page, :per_page]
                        
      # Returns a list of the videos in a group.
      create_api_method :get_videos,
                        "vimeo.groups.getVideos",
                        :required => [:group_id],
                        :optional => [:page, :per_page, :sort, :full_response]

      # Joins a group.
      create_api_method :join,
                        "vimeo.groups.join",
                        :required => [:group_id]
      
      # Leaves a group.
      create_api_method :leave,
                        "vimeo.groups.leave",
                        :required => [:group_id]

    end # Group
  end # Advanced
end # Vimeo