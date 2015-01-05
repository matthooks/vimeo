# Vimeo API Gem

[![Build Status](https://secure.travis-ci.org/matthooks/vimeo.png?branch=master)](http://travis-ci.org/matthooks/vimeo)
[![Dependency Status](https://gemnasium.com/matthooks/vimeo.png?travis)](https://gemnasium.com/matthooks/vimeo)
[![Code Climate](https://codeclimate.com/github/matthooks/vimeo.png)](https://codeclimate.com/github/matthooks/vimeo)

This gem implements a full-featured Ruby interface for the Vimeo API v2.

For a more in depth look at the API check out [Vimeo's Simple API Documentation](http://www.vimeo.com/api/docs/simple-api) or [Vimeo's Advanced API Documentation](http://www.vimeo.com/api/docs/advanced-api). I would also recommend checking out the [API Forums](http://www.vimeo.com/forum:api) if things aren't working as they should.

## Getting Started
To install Vimeo, add the gem to your Gemfile

    gem 'vimeo'

make sure to `bundle` afterwards. If you're not using bundler then `gem install vimeo`

## How to Use

There are two modules:

    Vimeo::Simple
    Vimeo::Advanced

## Simple API

Let's look at the [Simple API](http://www.vimeo.com/api/docs/simple-api) first.

The wrapper for the Simple API consists of several classes. To use the Simple API, just call one of the class methods. For example:

    user_info = Vimeo::Simple::User.info("matthooks")
    # =>
    # {
    #   "id":"888046",
    #   "display_name":"Matt Hooks",
    #   "created_on":"2008-10-30 14:17:32",
    #   "is_staff":"0",
    #   "is_plus":"0",
    #   "location":"Chicago, IL",
    #   "url":"http:\/\/blackholeinthemidwest.com\/",
    #   "bio":"",
    #   "profile_url":"http:\/\/vimeo.com\/matthooks",
    #   "videos_url":"http:\/\/vimeo.com\/matthooks\/videos",
    #   "total_videos_appears_ined":2,
    #   "total_videos_appears_in":0,
    #   "total_videos_liked":2,
    #   "total_contacts":3,
    #   "total_albums":0,
    #   "total_channels":1,
    #   "portrait_small":"http:\/\/images.vimeo.com\/11\/42\/16\/114216178\/114216178_30.jpg",
    #   "portrait_medium":"http:\/\/images.vimeo.com\/11\/42\/16\/114216178\/114216178_75.jpg",
    #   "portrait_large":"http:\/\/images.vimeo.com\/11\/42\/16\/114216178\/114216178_100.jpg",
    #   "portrait_huge":"http:\/\/images.vimeo.com\/11\/42\/16\/114216178\/114216178_300.jpg"
    # }

Thanks to HTTParty, the data is parsed and ready to use.

    user_info["location"]
    # => "Chicago, IL"

## Overview of the Simple API

### Vimeo::Simple::Activity

    Vimeo::Simple::Activity.user_did("username")
    Vimeo::Simple::Activity.happened_to_user("username")
    Vimeo::Simple::Activity.contacts_did("username")
    Vimeo::Simple::Activity.happened_to_contacts("username")
    Vimeo::Simple::Activity.everyone_did("username")

### Vimeo::Simple::Album

    Vimeo::Simple::Album.videos("album_id")
    Vimeo::Simple::Album.info("album_id")

### Vimeo::Simple::Channel

    Vimeo::Simple::Channel.videos("channelname")
    Vimeo::Simple::Channel.info("channelname")

### Vimeo::Simple::Group

    Vimeo::Simple::Group.videos("groupname")
    Vimeo::Simple::Group.users("groupname")
    Vimeo::Simple::Group.info("groupname")

### Vimeo::Simple::User

    Vimeo::Simple::User.info("username")
    Vimeo::Simple::User.videos("username")
    Vimeo::Simple::User.likes("username")
    Vimeo::Simple::User.appears_in("username")
    Vimeo::Simple::User.all_videos("username")
    Vimeo::Simple::User.subscriptions("username")
    Vimeo::Simple::User.albums("username")
    Vimeo::Simple::User.channels("username")
    Vimeo::Simple::User.groups("username")
    Vimeo::Simple::User.contacts_videos("username")
    Vimeo::Simple::User.contacts_like("username")

### Vimeo::Simple::Video

    Vimeo::Simple::Video.info("video_id")

## Advanced API

To use the [Advanced API](http://www.vimeo.com/api/docs/advanced-api), first you must authenticate your user using OAuth.

### Authentication Example using Rails

First, instantiate the Base class:

    base = Vimeo::Advanced::Base.new("consumer_key", "consumer_secret")

Get a request token, and save the token secret in the session hash.

    request_token = base.get_request_token
    session[:oauth_secret] = request_token.secret

Then, send your user to the authorization URL:

    redirect_to base.authorize_url

Once the user has allowed your application to access their account, they will be redirected to the callback URL you set up for your application. You will be given two parameters `oauth_token` and `oauth_verifier`. Re-instantiate your Base class, then get an access token.

    base = Vimeo::Advanced::Base.new("consumer_key", "consumer_secret")
    access_token = base.get_access_token(params[:oauth_token], session[:oauth_secret], params[:oauth_verifier])
    # You'll want to hold on to the user's access token and secret. I'll save it to the database.
    user.token = access_token.token
    user.secret = access_token.secret
    user.save

*Note*: if you are trying to get your access tokens manually, then the above block of code will be a little different:

  - `params[:oauth_token]` is the same as `request_token.token`
  - `params[:oauth_verifier]` is the code you see on Vimeo after you visit `base.authorize_url` and allow access to your account.

Now you've got everything you need to use the Advanced API. Let's get a user's videos:

    video = Vimeo::Advanced::Video.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)
    video.get_all("matthooks")

    # => {"videos"=> { ... }, "stat"=>"ok", "generated_in"=>"0.5753"}

Piece of cake.

Some methods have optional variables. Pass these as a hash at the end of a call.

    video.get_all("matthooks", :page => "2", :per_page => "50")

## Overview of the Advanced API

### Vimeo::Advanced::Album

    album = Vimeo::Advanced::Album.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    album.add_video("album_id", "video_id")
    album.create("title", "video_id", { :description => "description", "videos" => "123,124,125" })
    album.delete("album_id")
    album.get_all("user_id", { :page => "1", :per_page => "25", :sort => "newest" })
    album.get_videos("album_id", { :page => "1", :per_page => "25", :full_response => "0", :password => nil })
    album.remove_video("album_id", "video_id")
    album.set_description("album_id", "description")
    album.set_password("album_id", "password")
    album.get_title("album_id", "title")

### Vimeo::Advanced::Base

    base = Vimeo::Advanced::Base.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    base.check_access_token

### Vimeo::Advanced::Channel

    channel = Vimeo::Advanced::Channel.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    channel.add_video("channel_id", "video_id")
    channel.get_all({ :page => "1", :per_page => "25", :sort => "newest", :user_id => "user_id" })
    channel.get_info(channel_id)
    channel.get_moderators(channel_id, { :page => "1", :per_page => "25" })
    channel.get_subscribers(channel_id, { :page => "1", :per_page => "25" })
    channel.get_videos(channel_id, { :page => "1", :per_page => "25", :full_response => "0" })
    channel.remove_video("channel_id", "video_id")
    channel.subscribe("channel_id")
    channel.unsubscribe("channel_id")

### Vimeo::Advanced::Contact

    contact = Vimeo::Advanced::Contact.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    contact.get_all(user_id, { :page => "1", :per_page => "25", :sort => "newest" })
    contact.get_mutual(user_id, { :page => "1", :per_page => "25" })
    contact.get_online({ :page => "1", :per_page => "25" })
    contact.get_who_added(user_id, { :page => "1", :per_page => "25", :sort => "newest" })

### Vimeo::Advanced::Group

    group = Vimeo::Advanced::Group.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    group.add_video("group_id", "video_id")
    group.get_all({ :page => "1", :per_page => "25", :sort => "newest", :user_id => "user_id" })
    group.get_files("group_id", { :page => "1", :per_page => "25" })
    group.get_info("group_id")
    group.get_members("group_id", { :page => "1", :per_page => "25", :sort => "newest" })
    group.get_moderators("group_id", { :page => "1", :per_page => "25" })
    group.get_video_comments("group_id", "video_id", { :page => "1", :per_page => "25" })
    group.get_videos("group_id", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" })
    group.join("group_id")
    group.leave("group_id")

### Vimeo::Advanced::GroupEvents

    group_events = Vimeo::Advanced::GroupEvents.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    group_events.get_month("group_id", { :page => "1", :per_page => "25", :month => nil, :year => nil })
    group_events.get_past("group_id", { :page => "1", :per_page => "25" })
    group_events.get_year("group_id", { :page => "1", :per_page => "25" })

### Vimeo::Advanced::GroupForums

    group_forums = Vimeo::Advanced::GroupForums.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    group_forums.get_topic_comments("group_id", "topic_id", { :page => "1", :per_page => "25" })
    group_forums.get_topics("group_id", { :page => "1", :per_page => "25" })

### Vimeo::Advanced::Person

    person = Vimeo::Advanced::Person.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    person.add_contact("user_id")
    person.add_subscription("user_id", "types") # Types is a comma-delimited string. Valid: "likes", "appears", "uploads"
    person.find_by_email("user_id")
    person.get_hd_embeds
    person.get_info("user_id")
    person.get_portrait_urls("user_id")
    person.remove_contact("user_id")
    person.remove_subscription("user_id", "types") # Types is a comma-delimited string. Valid: "likes", "appears", "uploads"

### Vimeo::Advanced::Test

    test = Vimeo::Advanced::Test.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    test.echo
    test.null
    test.login

### Vimeo::Advanced::Upload

    upload = Vimeo::Advanced::Upload.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    # Other than get_quota, none of these methods should be called directly. The 'upload' method uses these internally.
    upload.check_ticket("ticket_id")
    upload.complete("ticket_id", "filename")
    upload.get_ticket
    upload.get_quota
    upload.verify_chunks("ticket_id")

    # all-in-one solution, supports File, String (a file path), #read
    video_id = upload.upload("movie.mp4")

### Vimeo::Advanced::Video

    video = Vimeo::Advanced::Video.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    video.add_cast("video_id", "user_id", { :role => nil })
    video.add_photos("video_id", "photo_urls")
    video.add_tags("video_id", "tags")
    video.clear_tags("video_id")
    video.delete("video_id")
    video.get_all("user_id", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" })
    video.get_appears_in("user_id", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" })
    video.get_by_tag("tag", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" })
    video.get_cast("video_id", { :page => "1", :per_page => "25" })
    video.get_contacts_liked("user_id", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" })
    video.get_contacts_uploaded("user_id", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" })
    video.get_collections("video_id")
    video.get_info("video_id")
    video.get_likes("user_id", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" })
    video.get_subscriptions("user_id", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" })
    video.get_thumbnail_urls("video_id")
    video.get_uploaded("user_id", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" })
    video.remove_cast("video_id", "user_id")
    video.remove_tag("video_id", "tag_id")
    video.search("query", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest", :user_id => nil })
    video.set_description("video_id", "description")
    video.set_like("video_id", "like")
    video.set_privacy("video_id", "privacy", { :users => nil, :password => nil })
    video.set_title("video_id", "title")

    # comments
    video.add_comment("video_id", "comment_text", { :reply_to_comment_id => nil })
    video.delete_comment("video_id", "comment_id")
    video.edit_comment("video_id", "comment_id", "comment_text")
    video.get_comments_list("video_id", { :page => "1", :per_page => "25" })

### Vimeo::Advanced::VideoEmbed

    video_embed = Vimeo::Advanced::VideoEmbed.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

    video_embed.get_presets({ :page => "1", :per_page => "25" })
    video_embed.set_preset("video_id", "preset_id")
    video_embed.set_privacy("video_id", "privacy", { :approved_domains => ["example.com"].to_json })

## Uploads

Uploads are working! In order to upload a file, create your upload object, like so:

    upload = Vimeo::Advanced::Upload.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)

Then call the upload method:

    upload.upload("/path/to/file") # You can also pass a File object or any IO.

The upload method will automatically get an upload ticket, perform the multipart POST, verify the file chunks and then complete the upload.

## Todo

* Fix tests that cannot be stubbed because of OAuth nonce.
* Better structure. There's too many classes. Is there a way to simplify the Advanced API?
* Better error handling.
* More re-factoring.
* Make tests more robust and faster. If anyone has any ideas let me know.

## Contributors

* [matthooks](http://github.com/matthooks)
* [sirlantis](http://github.com/sirlantis)

## Thanks to

* [HTTParty](http://github.com/jnunemaker/httparty): Easily one of the best tools I have used since I started using Ruby.
* [Jeweler](http://github.com/technicalpickles/jeweler): Great tool for creating gems for Github.

### Copyright (c) 2009-2010 Matt Hooks. See LICENSE for details.
