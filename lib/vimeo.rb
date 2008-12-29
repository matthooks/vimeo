require 'rubygems'
require 'httparty'
require 'digest/md5'
require 'cgi'

class VimeoSimple
  include HTTParty
  base_uri 'vimeo.com/api'

  # USER
  def self.user_info(username)
    get("/#{username}/info.json")
  end
  
  def self.user_clips(username)
    get("/#{username}/clips.json")
  end
  
  def self.user_likes(username)
    get("/#{username}/likes.json")
  end
  
  def self.user_appears_in(username)
    get("/#{username}/appears_in.json")
  end
  
  def self.user_all_clips(username)
    get("/#{username}/all_clips.json")
  end
  
  def self.user_subscriptions(username)
    get("/#{username}/subscriptions.json")
  end
  
  def self.user_albums(username)
    get("/#{username}/albums.json")
  end
  
  def self.user_channels(username)
    get("/#{username}/channels.json")
  end
  
  def self.user_groups(username)
    get("/#{username}/groups.json")
  end
  
  def self.user_contacts_clips(username)
    get("/#{username}/contacts_clips.json")
  end
  
  def self.user_contacts_like(username)
    get("/#{username}/contacts_like.json")
  end
  
  # CLIPS
  def self.clip_info(video_id)
    get("/clip/#{video_id}.json")
  end
  
  # ACTIVITY
  def self.activity_user_did(username)
    get("/activity/#{username}/user_did.json")
  end
  
  def self.activity_happened_to_user(username)
    get("/activity/#{username}/happened_to_user.json")
  end
  
  def self.activity_contacts_did(username)
    get("/activity/#{username}/contacts_did.json")
  end
  
  def self.activity_happened_to_contacts(username)
    get("/activity/#{username}/happened_to_contacts.json")
  end
  
  def self.activity_everyone_did(username)
    get("/activity/#{username}/everyone_did.json")
  end
  
  # GROUPS
  def self.group_clips(groupname)
    get("/group/#{groupname}/clips.json")
  end
  
  def self.group_users(groupname)
    get("/group/#{groupname}/users.json")
  end
  
  def self.group_info(groupname)
    get("/group/#{groupname}/info.json")
  end
  
  # CHANNELS
  def self.channel_clips(channelname)
    get("/channel/#{channelname}/clips.json")
  end
  
  def self.channel_info(channelname)
    get("/channel/#{channelname}/info.json")
  end
  
  # ALBUMS
  def self.album_clips(album_id)
    get("/album/#{album_id}/clips.json")
  end
  
  def self.album_info(album_id)
    get("/album/#{album_id}/info.json")
  end
  
end

class VimeoAdvanced
  include HTTParty
  base_uri 'vimeo.com'

  def initialize(api_key, secret, format_options={})
    @auth = { :api_key => api_key }
    @secret = secret
    # TODO: implement format_options
  end
  
  # HELPERS
  def login_link(perms)
    api_sig = generate_api_sig :perms => perms
    "http://vimeo.com/services/auth/?api_key=#{@auth[:api_key]}&perms=#{perms}&api_sig=#{api_sig}"
  end
  
  # TODO: Implement a function that returns the correct upload URL
  
  def upload_sig(ticket_id, auth_token)
    sig_options = {
      :ticket_id => ticket_id,
      :auth_token => auth_token
    }
    
    generate_api_sig sig_options
  end
  
  # TEST METHODS
  def test_echo(options={})
    method = "vimeo.test.echo"
    options.merge!(:method => method)
    api_sig = generate_api_sig options
    options.merge!(:api_sig => api_sig)
    self.class.post("/api/rest", :query => options)
  end
  
  def test_null(auth_token)
    method = "vimeo.test.null"
    api_sig = generate_api_sig :auth_token => auth_token, :method => method
    self.class.post("/api/rest", :query => {
      :api_key => @auth[:api_key],
      :method => method,
      :auth_token => auth_token,
      :api_sig => api_sig
    })
  end

  def test_login(auth_token)
    method = "vimeo.test.login"
    api_sig = generate_api_sig :auth_token => auth_token, :method => method
    self.class.post("/api/rest", :query => {
      :api_key => @auth[:api_key],
      :auth_token => auth_token,
      :method => method,
      :api_sig => api_sig
    })
  end
  
  # AUTHENTICATION
  def get_token(frob)
    method = "vimeo.auth.getToken"
    api_sig = generate_api_sig :frob => frob, :method => method
    self.class.post("/api/rest", :query => {
      :api_key => @auth[:api_key],
      :frob => frob,
      :method => method,
      :api_sig => api_sig
    })
  end
  
  def get_frob
    method = "vimeo.auth.getFrob"
    api_sig = generate_api_sig :method => method
    self.class.post("/api/rest", :query => {
      :api_key => @auth[:api_key],
      :method => method,
      :api_sig => api_sig
    })
  end
  
  def check_token(auth_token)
    method = "vimeo.auth.checkToken"
    api_sig = generate_api_sig :auth_token => auth_token, :method => method
    self.class.post("/api/rest", :query => {
      :api_key => @auth[:api_key],
      :auth_token => auth_token,
      :method => method,
      :api_sig => api_sig
    })
  end
  
  # LISTS OF VIDEOS
  def videos_get_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0 })
    page = options[:page]
    per_page = options[:per_page]
    full_response = options[:full_response]
    method = "vimeo.videos.getList"
    api_sig = generate_api_sig :user_id => user_id, :page => page, :per_page => per_page, :fullResponse => full_response, :method => method
    self.class.post("/api/rest", :query => {
      :api_key => @auth[:api_key],
      :user_id => user_id,
      :page => page,
      :per_page => per_page,
      :fullResponse => full_response,
      :method => method,
      :api_sig => api_sig
    })
  end
  
  def videos_get_uploaded_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
    page = options[:page]
    per_page = options[:per_page]
    full_response = options[:full_response]
    auth_token = options[:auth_token]
    method = "vimeo.videos.getUploadedList"
    api_sig = generate_api_sig :user_id => user_id, :page => page, :per_page => per_page, :fullResponse => full_response, :auth_token => auth_token, :method => method
    self.class.post("/api/rest", :query => {
      :api_key => @auth[:api_key],
      :user_id => user_id,
      :page => page,
      :per_page => per_page,
      :fullResponse => full_response,
      :auth_token => auth_token,
      :method => method,
      :api_sig => api_sig
    })
  end
  
  def videos_get_appears_in_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
    page = options[:page]
    per_page = options[:per_page]
    full_response = options[:full_response]
    auth_token = options[:auth_token]
    method = "vimeo.videos.getAppearsInList"
    api_sig = generate_api_sig :user_id => user_id, :page => page, :per_page => per_page, :fullResponse => full_response, :auth_token => auth_token, :method => method
    self.class.post("/api/rest", :query => {
      :api_key => @auth[:api_key],
      :user_id => user_id,
      :page => page,
      :per_page => per_page,
      :fullResponse => full_response,
      :auth_token => auth_token,
      :method => method,
      :api_sig => api_sig
    })
  end
  
  def videos_get_subscriptions_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
    page = options[:page]
    per_page = options[:per_page]
    full_response = options[:full_response]
    auth_token = options[:auth_token]
    method = "vimeo.videos.getSubscriptionsList"
    api_sig = generate_api_sig :user_id => user_id, :page => page, :per_page => per_page, :fullResponse => full_response, :auth_token => auth_token, :method => method
    self.class.post("/api/rest", :query => {
      :api_key => @auth[:api_key],
      :user_id => user_id,
      :page => page,
      :per_page => per_page,
      :fullResponse => full_response,
      :auth_token => auth_token,
      :method => method,
      :api_sig => api_sig
    })
  end
  
  def videos_get_list_by_tag(tag, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
    user_id = options[:user_id]
    page = options[:page]
    per_page = options[:per_page]
    full_response = options[:full_response]
    auth_token = options[:auth_token]
    method = "vimeo.videos.getListByTag"
    
    sig_options = {
      :tag => tag,
      :page => page,
      :per_page => per_page,
      :fullResponse => full_response,
      :auth_token => auth_token,
      :method => method
    }
    sig_options.merge! :user_id => user_id if !user_id.nil?
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def videos_get_like_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
    page = options[:page]
    per_page = options[:per_page]
    full_response = options[:full_response]
    auth_token = options[:auth_token]
    method = "vimeo.videos.getLikeList"
    
    sig_options = {
      :user_id => user_id,
      :page => page,
      :per_page => per_page,
      :fullResponse => full_response,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def videos_get_contacts_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
    page = options[:page]
    per_page = options[:per_page]
    full_response = options[:full_response]
    auth_token = options[:auth_token]
    method = "vimeo.videos.getContactsList"
    
    sig_options = {
      :user_id => user_id,
      :page => page,
      :per_page => per_page,
      :fullResponse => full_response,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def videos_get_contacts_like_list(user_id, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
    page = options[:page]
    per_page = options[:per_page]
    full_response = options[:full_response]
    auth_token = options[:auth_token]
    method = "vimeo.videos.getContactsLikeList"
    
    sig_options = {
      :user_id => user_id,
      :page => page,
      :per_page => per_page,
      :fullResponse => full_response,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def videos_search(q, options={ :page => 1, :per_page => 25, :full_response => 0, :auth_token => nil })
    user_id = options[:user_id]
    contacts_only = options[:contacts_only]
    page = options[:page]
    per_page = options[:per_page]
    full_response = options[:full_response]
    auth_token = options[:auth_token]
    method = "vimeo.videos.search"
    escaped_query = CGI.escape(q)
    
    sig_options = {
      :query => escaped_query,
      :page => page,
      :per_page => per_page,
      :fullResponse => full_response,
      :auth_token => auth_token,
      :method => method
    }
    sig_options.merge! :user_id => user_id if !user_id.nil?
    sig_options.merge! :contacts_only => contacts_only if !contacts_only.nil?
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # DEALING WITH SPECIFIC VIDEOS
  def video_get_info(video_id, auth_token=nil)
    method = "vimeo.videos.getInfo"
    
    sig_options = {
      :video_id => video_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_delete(video_id, auth_token)
    method = "vimeo.videos.delete"
    
    sig_options = {
      :video_id => video_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_get_thumbnail_url(video_id, size=100)
    method = "vimeo.videos.getThumbnailUrl"
    
    sig_options = {
      :video_id => video_id,
      :size => size,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_set_title(video_id, title, auth_token)
    method = "vimeo.videos.setTitle"
    escaped_title = CGI.escape(title)
    
    sig_options = {
      :video_id => video_id,
      :title => escaped_title,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_set_caption(video_id, caption, auth_token)
    method = "vimeo.videos.setCaption"
    escaped_caption = CGI.escape(caption)
    
    sig_options = {
      :video_id => video_id,
      :caption => escaped_caption,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_set_favorite(video_id, favorite, auth_token)
    method = "vimeo.videos.setFavorite"
    f = favorite ? true : false
    
    sig_options = {
      :video_id => video_id,
      :favorite => f,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_add_tags(video_id, tags, auth_token)
    method = "vimeo.videos.addTags"
    
    sig_options = {
      :video_id => video_id,
      :tags => tags,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_remove_tag(video_id, tag_id, auth_token)
    method = "vimeo.videos.removeTag"
    
    sig_options = {
      :video_id => video_id,
      :tag_id => tag_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_clear_tags(video_id, auth_token)
    method = "vimeo.videos.clearTags"
    
    sig_options = {
      :video_id => video_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_add_cast(video_id, user_id, auth_token, options={})
    method = "vimeo.videos.addCast"
    
    sig_options = {
      :video_id => video_id,
      :user_id => user_id,
      :auth_token => auth_token,
      :method => method
    }
    sig_options.merge! :role => options[:role] unless options[:role].nil?
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_get_cast(video_id, auth_token=nil)
    method = "vimeo.videos.getCast"
    
    sig_options = {
      :video_id => video_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_remove_cast(video_id, user_id, auth_token)
    method = "vimeo.videos.removeCast"
    
    sig_options = {
      :video_id => video_id,
      :user_id => user_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # TODO: Add ability to specify users
  def video_set_privacy(video_id, privacy, auth_token)
    method = "vimeo.videos.setPrivacy"
    
    sig_options = {
      :video_id => video_id,
      :privacy => privacy,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # VIDEO COMMENTS
  def video_get_comments_list(video_id)
    method = "vimeo.videos.comments.getList"
    
    sig_options = {
      :video_id => video_id,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_add_comment(video_id, comment_text, auth_token, options={})
    reply_to_comment_id = options[:reply_to_comment_id]
    method = "vimeo.videos.comments.addComment"

    sig_options = {
      :video_id => video_id,
      :comment_text => comment_text,
      :auth_token => auth_token,
      :method => method
    }
    sig_options.merge! :reply_to_comment_id => reply_to_comment_id unless reply_to_comment_id.nil?
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_delete_comment(video_id, comment_id, auth_token)
    method = "vimeo.videos.comments.deleteComment"

    sig_options = {
      :video_id => video_id,
      :comment_id => comment_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_edit_comment(video_id, comment_id, comment_text, auth_token)
    method = "vimeo.videos.comments.editComment"

    sig_options = {
      :video_id => video_id,
      :comment_id => comment_id,
      :comment_text => comment_text,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # PEOPLE (USERS)
  def people_find_by_user_name(username)
    method = "vimeo.people.findByUserName"

    sig_options = {
      :username => username,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def people_find_by_email(find_email)
    method = "vimeo.people.findByEmail"

    sig_options = {
      :find_email => find_email,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def people_get_info(user_id)
    method = "vimeo.people.getInfo"

    sig_options = {
      :user_id => user_id,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # TODO: This seems to be returning nil from Vimeo... not implemented?
  def people_get_portrait_url(user_id, options={})
    size = options[:size]
    method = "vimeo.people.getPortraitUrl"

    sig_options = {
      :user_id => user_id,
      :method => method
    }
    sig_options.merge! :size => size unless size.nil?
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # TODO: Not working on Vimeo's side
  def people_add_contact(user_id, auth_token)
    method = "vimeo.people.addContact"

    sig_options = {
      :user_id => user_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # TODO: Not working on Vimeo's side
  def people_remove_contact(user_id, auth_token)
    method = "vimeo.people.removeContact"

    sig_options = {
      :user_id => user_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def people_get_upload_status(user_id, auth_token)
    method = "vimeo.people.getUploadStatus"

    sig_options = {
      :user_id => user_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # TODO: Verify input for type?
  def people_add_subscription(user_id, type, auth_token)
    method = "vimeo.people.addSubscription"

    sig_options = {
      :user_id => user_id,
      :type => type,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # TODO: Verify input for type?
  def people_remove_subscription(user_id, type, auth_token)
    method = "vimeo.people.removeSubscription"

    sig_options = {
      :user_id => user_id,
      :type => type,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # CONTACTS
  def contacts_get_list(user_id)
    method = "vimeo.contacts.getList"

    sig_options = {
      :user_id => user_id,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # GROUPS
  # TODO: Only takes group_id as int, not group name
  def groups_get_members(group_id)
    method = "vimeo.groups.getMembers"

    sig_options = {
      :group_id => group_id,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  # UPLOAD
  def video_get_upload_ticket(auth_token)
    method = "vimeo.videos.getUploadTicket"

    sig_options = {
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  def video_check_upload_status(ticket_id, auth_token)
    method = "vimeo.videos.checkUploadStatus"

    sig_options = {
      :ticket_id => ticket_id,
      :auth_token => auth_token,
      :method => method
    }
    
    api_sig = generate_api_sig sig_options
    query = sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
    
    self.class.post("/api/rest", :query => query)
  end
  
  private
  
    # Keys must be sorted alphabetically
    def generate_api_sig(options={})
      options.merge! @auth
      api_sig = options.sort { |a, b| a.to_s <=> b.to_s }.join
      Digest::MD5.hexdigest("#{@secret}#{api_sig}")
    end
  
end