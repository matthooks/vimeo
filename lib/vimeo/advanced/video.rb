module Vimeo
  module Advanced

    class Video < Vimeo::Advanced::Base

      def get_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0 })
        sig_options = {
          :user_id => user_id,
          :page => options[:page],
          :per_page => options[:per_page],
          :fullResponse => options[:full_response],
          :method => "vimeo.videos.getList"
        }
        
        make_request sig_options
      end

      def get_uploaded_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
        sig_options = {
          :user_id => user_id,
          :page => options[:page],
          :per_page => options[:per_page],
          :fullResponse => options[:full_response],
          :auth_token => options[:auth_token],
          :method => "vimeo.videos.getUploadedList"
        }
        
        make_request sig_options
      end

      def get_appears_in_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
        sig_options = {
          :user_id => user_id,
          :page => options[:page],
          :per_page => options[:per_page],
          :fullResponse => options[:full_response],
          :method => "vimeo.videos.getAppearsInList"
        }
        
        make_request sig_options
      end

      def get_subscriptions_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
        sig_options = {
          :user_id => user_id,
          :page => options[:page],
          :per_page => options[:per_page],
          :fullResponse => options[:full_response],
          :auth_token => options[:auth_token],
          :method => "vimeo.videos.getSubscriptionsList"
        }
        
        make_request sig_options
      end

      def get_list_by_tag(tag, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
        user_id = options[:user_id]

        sig_options = {
          :tag => tag,
          :page => options[:page],
          :per_page => options[:per_page],
          :fullResponse => options[:full_response],
          :auth_token => options[:auth_token],
          :method => "vimeo.videos.getListByTag"
        }
        sig_options.merge! :user_id => user_id if !user_id.nil?

        make_request sig_options
      end

      def get_like_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
        sig_options = {
          :user_id => user_id,
          :page => options[:page],
          :per_page => options[:per_page],
          :fullResponse => options[:full_response],
          :auth_token => options[:auth_token],
          :method => "vimeo.videos.getLikeList"
        }

        make_request sig_options
      end

      def get_contacts_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
        sig_options = {
          :user_id => user_id,
          :page => options[:page],
          :per_page => options[:per_page],
          :fullResponse => options[:full_response],
          :auth_token => options[:auth_token],
          :method => "vimeo.videos.getContactsList"
        }

        make_request sig_options
      end

      def get_contacts_like_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
        sig_options = {
          :user_id => user_id,
          :page => options[:page],
          :per_page => options[:per_page],
          :fullResponse => options[:full_response],
          :auth_token => options[:auth_token],
          :method => "vimeo.videos.getContactsLikeList"
        }

        make_request sig_options
      end

      def search(q, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
        user_id = options[:user_id]
        contacts_only = options[:contacts_only]

        sig_options = {
          :query => q,
          :page => options[:page],
          :per_page => options[:per_page],
          :fullResponse => options[:full_response],
          :auth_token => options[:auth_token],
          :method => "vimeo.videos.search"
        }
        sig_options.merge! :user_id => user_id if !user_id.nil?
        sig_options.merge! :contacts_only => contacts_only if !contacts_only.nil?

        make_request sig_options
      end

      def get_info(video_id, auth_token=nil)
        sig_options = {
          :video_id => video_id,
          :auth_token => auth_token,
          :method => "vimeo.videos.getInfo"
        }

        make_request sig_options
      end

      def delete(video_id, auth_token)
        sig_options = {
          :video_id => video_id,
          :auth_token => auth_token,
          :method => "vimeo.videos.delete"
        }

        make_request sig_options
      end

      def get_thumbnail_url(video_id, size=100)
        sig_options = {
          :video_id => video_id,
          :size => size,
          :method => "vimeo.videos.getThumbnailUrl"
        }

        make_request sig_options
      end

      def set_title(video_id, title, auth_token)
        sig_options = {
          :video_id => video_id,
          :title => title,
          :auth_token => auth_token,
          :method => "vimeo.videos.setTitle"
        }

        make_request sig_options
      end

      def set_caption(video_id, caption, auth_token)
        sig_options = {
          :video_id => video_id,
          :caption => caption,
          :auth_token => auth_token,
          :method => "vimeo.videos.setCaption"
        }

        make_request sig_options
      end

      def set_favorite(video_id, favorite, auth_token)
        f = favorite ? true : false

        sig_options = {
          :video_id => video_id,
          :favorite => f,
          :auth_token => auth_token,
          :method => "vimeo.videos.setFavorite"
        }

        make_request sig_options
      end

      def add_tags(video_id, tags, auth_token)
        sig_options = {
          :video_id => video_id,
          :tags => tags,
          :auth_token => auth_token,
          :method => "vimeo.videos.addTags"
        }

        make_request sig_options
      end

      def remove_tag(video_id, tag_id, auth_token)
        sig_options = {
          :video_id => video_id,
          :tag_id => tag_id,
          :auth_token => auth_token,
          :method => "vimeo.videos.removeTag"
        }

        make_request sig_options
      end

      def clear_tags(video_id, auth_token)
        sig_options = {
          :video_id => video_id,
          :auth_token => auth_token,
          :method => "vimeo.videos.clearTags"
        }

        make_request sig_options
      end

      def add_cast(video_id, user_id, auth_token, options={})
        role = options[:role]
        
        sig_options = {
          :video_id => video_id,
          :user_id => user_id,
          :auth_token => auth_token,
          :method => "vimeo.videos.addCast"
        }
        sig_options.merge! :role => role unless role.nil?

        make_request sig_options
      end

      def get_cast(video_id, auth_token=nil)
        sig_options = {
          :video_id => video_id,
          :auth_token => auth_token,
          :method => "vimeo.videos.getCast"
        }

        make_request sig_options
      end

      def remove_cast(video_id, user_id, auth_token)
        sig_options = {
          :video_id => video_id,
          :user_id => user_id,
          :auth_token => auth_token,
          :method => "vimeo.videos.removeCast"
        }

        make_request sig_options
      end

      # TODO: Add ability to specify users
      def set_privacy(video_id, privacy, auth_token)
        sig_options = {
          :video_id => video_id,
          :privacy => privacy,
          :auth_token => auth_token,
          :method => "vimeo.videos.setPrivacy"
        }

        make_request sig_options
      end

      def get_comments_list(video_id)
        sig_options = {
          :video_id => video_id,
          :method => "vimeo.videos.comments.getList"
        }

        make_request sig_options
      end

      def add_comment(video_id, comment_text, auth_token, options={})
        reply_to_comment_id = options[:reply_to_comment_id]

        sig_options = {
          :video_id => video_id,
          :comment_text => comment_text,
          :auth_token => auth_token,
          :method => "vimeo.videos.comments.addComment"
        }
        sig_options.merge! :reply_to_comment_id => reply_to_comment_id unless reply_to_comment_id.nil?

        make_request sig_options
      end

      def delete_comment(video_id, comment_id, auth_token)
        sig_options = {
          :video_id => video_id,
          :comment_id => comment_id,
          :auth_token => auth_token,
          :method => "vimeo.videos.comments.deleteComment"
        }

        make_request sig_options
      end

      def edit_comment(video_id, comment_id, comment_text, auth_token)
        sig_options = {
          :video_id => video_id,
          :comment_id => comment_id,
          :comment_text => comment_text,
          :auth_token => auth_token,
          :method => "vimeo.videos.comments.editComment"
        }

        make_request sig_options
      end

    end

  end # Advanced
end # Vimeo