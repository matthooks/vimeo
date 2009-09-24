module Vimeo
  module Advanced
    class Video < Vimeo::Advanced::Base

      create_api_method :add_cast,
                        "vimeo.videos.addCast",
                        :required => [:auth_token, :video_id, :user_id],
                        :optional => [:role]

      create_api_method :add_photos,
                        "vimeo.videos.addPhotos",
                        :required => [:auth_token, :video_id, :photo_urls]

      create_api_method :add_tags,
                        "vimeo.videos.addTags",
                        :required => [:auth_token, :video_id, :tags]

      create_api_method :clear_tags,
                        "vimeo.videos.clearTags",
                        :required => [:auth_token, :video_id]

      create_api_method :delete,
                        "vimeo.videos.delete",
                        :required => [:auth_token, :video_id]

      create_api_method :get_all,
                        "vimeo.videos.getAll",
                        :required => [:user_id],
                        :optional => [:page, :per_page, :full_response, :sort]

      create_api_method :get_appears_in,
                        "vimeo.videos.getAppearsIn",
                        :required => [:user_id],
                        :optional => [:page, :per_page, :full_response, :sort]

      create_api_method :get_by_tag,
                        "vimeo.videos.getByTag",
                        :required => [:tag],
                        :optional => [:page, :per_page, :full_response, :sort]

      create_api_method :get_cast,
                        "vimeo.videos.getCast",
                        :required => [:video_id],
                        :optional => [:page, :per_page]

      create_api_method :get_contacts_liked,
                        "vimeo.videos.getContactsLiked",
                        :required => [:user_id],
                        :optional => [:page, :per_page, :full_response, :sort]

      create_api_method :get_contacts_uploaded,
                        "vimeo.videos.getContactsUploaded",
                        :required => [:user_id],
                        :optional => [:page, :per_page, :full_response, :sort]

      create_api_method :get_info,
                        "vimeo.videos.getInfo",
                        :required => [:video_id]

      create_api_method :get_likes,
                        "vimeo.videos.getLikes",
                        :required => [:user_id],
                        :optional => [:page, :per_page, :full_response, :sort]

      create_api_method :get_subscriptions,
                        "vimeo.videos.getSubscriptions",
                        :required => [:user_id],
                        :optional => [:page, :per_page, :full_response, :sort]

      create_api_method :get_thumbnail_urls,
                        "vimeo.videos.getThumbnailUrls",
                        :required => [:video_id]

      create_api_method :get_uploaded,
                        "vimeo.videos.getUploaded",
                        :required => [:user_id],
                        :optional => [:page, :per_page, :full_response, :sort]

      create_api_method :remove_cast,
                        "vimeo.videos.removeCast",
                        :required => [:auth_token, :video_id, :user_id]

      create_api_method :remove_tag,
                        "vimeo.videos.removeTag",
                        :required => [:auth_token, :video_id, :tag_id]

      create_api_method :search,
                        "vimeo.videos.search",
                        :required => [:query],
                        :optional => [:page, :per_page, :full_response, :sort, :user_id]

      create_api_method :set_description,
                        "vimeo.videos.setDescription",
                        :required => [:auth_token, :video_id, :description]

      create_api_method :set_like,
                        "vimeo.videos.setLike",
                        :required => [:auth_token, :video_id, :like]

      create_api_method :set_privacy,
                        "vimeo.videos.setPrivacy",
                        :required => [:auth_token, :video_id, :privacy],
                        :optional => [:users, :password]

      create_api_method :set_title,
                        "vimeo.videos.setTitle",
                        :required => [:auth_token, :video_id, :title]

      
      # comments
      create_api_method :add_comment,
                        "vimeo.videos.comments.addComment",
                        :required => [:auth_token, :video_id, :comment_text],
                        :optional => [:reply_to_comment_id]

      create_api_method :delete_comment,
                        "vimeo.videos.comments.deleteComment",
                        :required => [:auth_token, :video_id, :comment_id]

      create_api_method :edit_comment,
                        "vimeo.videos.comments.editComment",
                        :required => [:auth_token, :video_id, :comment_id, :comment_text]

      create_api_method :get_comments_list,
                        "vimeo.videos.comments.getList",
                        :required => [:video_id],
                        :optional => [:page, :per_page]

    end # Video
  end # Advanced
end # Vimeo