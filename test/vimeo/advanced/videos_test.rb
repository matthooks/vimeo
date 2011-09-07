require 'test_helper'

class VideoTest < Test::Unit::TestCase

  context "vimeo advanced video" do
    
    setup do
      @video = Vimeo::Advanced::Video.new("12345", "secret", :token => "token", :secret => "secret")
    end

    should "be able to add cast to a video" do
      stub_post("?video_id=video_id&api_key=12345&user_id=user_id&format=json&method=vimeo.videos.addCast&auth_token=token&api_sig=d4490b9ebe5914fe2e05756dd6fb1db0", "advanced/video/add_cast.json")
      response = @video.add_cast("video_id", "user_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to add photos to a video" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.addPhotos&photo_urls=photo_urls&auth_token=token&api_sig=25e09737829e9a0c3a57201ada350b03", "advanced/video/add_photos.json")
      response = @video.add_photos("video_id", "photo_urls")
      
      assert_equal "ok", response["stat"]
    end

    should "be able to add tags to a video" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.addTags&auth_token=token&tags=tags&api_sig=9969e062d985a91363630d2003843341", "advanced/video/add_tags.json")
      response = @video.add_tags("video_id", "tags")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to clear tags from a video" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.clearTags&auth_token=token&api_sig=b901229a90f9f2d99d82d71da269573f", "advanced/video/clear_tags.json")
      response = @video.clear_tags("video_id")
      
      assert_equal "ok", response["stat"]
    end

    should "be able to delete a video" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.delete&auth_token=token&api_sig=55a6902be853ed835d5f9f359fd66719", "advanced/video/delete.json")
      response = @video.delete("video_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get all videos from a user" do
      stub_post("?api_key=12345&user_id=user_id&format=json&method=vimeo.videos.getAll&api_sig=0b828f177a2357d8d6caaa53443acbd1", "advanced/video/get_all.json")
      response = @video.get_all("user_id")
      
      assert_equal "ok", response["stat"]
    end

    should "be able to get all videos a user appears in" do
      stub_post("?api_key=12345&user_id=user_id&format=json&method=vimeo.videos.getAppearsIn&api_sig=e1c50479c4e304a7eeb16b3f85eccc80", "advanced/video/get_appears_in.json")
      response = @video.get_appears_in("user_id")
      
      assert_equal "ok", response["stat"]
    end

    should "be able to get videos by tag" do
      stub_post("?api_key=12345&format=json&method=vimeo.videos.getByTag&tag=tag&api_sig=d8fde9128d34b6f986dd3712ea4f1034", "advanced/video/get_by_tag.json")
      response = @video.get_by_tag("tag")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get the cast of a video" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.getCast&api_sig=b5d96ed4f1b72c42480afb4c0e0a1a61", "advanced/video/get_cast.json")
      response = @video.get_cast("video_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get videos a user's contacts liked" do
      stub_post("?api_key=12345&user_id=user_id&format=json&method=vimeo.videos.getContactsLiked&api_sig=6069cc86ec692d50889733472da30e72", "advanced/video/get_contacts_liked.json")
      response = @video.get_contacts_liked("user_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get videos a user's contacts uploaded" do
      stub_post("?api_key=12345&user_id=user_id&format=json&method=vimeo.videos.getContactsUploaded&api_sig=7e3caceb0edfbf4fa143410ca0c9549e", "advanced/video/get_contacts_uploaded.json")
      response = @video.get_contacts_uploaded("user_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get info about a video" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.getInfo&api_sig=0f1a7df7325961a0cf352da6264e913f", "advanced/video/get_info.json")
      response = @video.get_info("video_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get the videos a user has liked" do
      stub_post("?api_key=12345&user_id=user_id&format=json&method=vimeo.videos.getLikes&api_sig=49705aaa8cfb4bf4362ba5f81f4fe0df", "advanced/video/get_likes.json")
      response = @video.get_likes("user_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get a user's subscriptions" do
      stub_post("?api_key=12345&user_id=user_id&format=json&method=vimeo.videos.getSubscriptions&api_sig=892782d6bef613e66da3dcb14427afdf", "advanced/video/get_subscriptions.json")
      response = @video.get_subscriptions("user_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get thumbnail urls for a video" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.getThumbnailUrls&api_sig=faf1c7ac2296d9eb56656baa4a98c9d6", "advanced/video/get_thumbnail_urls.json")
      response = @video.get_thumbnail_urls("video_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get all videos a user has uploaded" do
      stub_post("?api_key=12345&user_id=user_id&format=json&method=vimeo.videos.getUploaded&api_sig=f1fb4954a2a261ed195d2ad47e3c9702", "advanced/video/get_uploaded.json")
      response = @video.get_uploaded("user_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to remove cast from a video" do
      stub_post("?video_id=video_id&api_key=12345&user_id=user_id&format=json&method=vimeo.videos.removeCast&auth_token=token&api_sig=31edc8eb16e2bc192d2b04405a7577c5", "advanced/video/remove_cast.json")
      response = @video.remove_cast("video_id", "user_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to remove a tag from a video" do
      stub_post("?video_id=video_id&api_key=12345&tag_id=tag_id&format=json&method=vimeo.videos.removeTag&auth_token=token&api_sig=8a0f215d43a6cd5ecdb07525f19323d6", "advanced/video/remove_tag.json")
      response = @video.remove_tag("video_id", "tag_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to search for videos" do
      stub_post("?api_key=12345&query=query&format=json&method=vimeo.videos.search&api_sig=16df9ac70be74b29f1660e9997d3d0df", "advanced/video/search.json")
      response = @video.search("query")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to set the description of a video" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.setDescription&description=description&auth_token=token&api_sig=b80965c8c5f62f006c7d897fc9ce10b2", "advanced/video/set_description.json")
      response = @video.set_description("video_id", "description")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to set the like of a video" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.setLike&like=like&auth_token=token&api_sig=55d3ad34bc4015cc4b0b8c1bf36ca68e", "advanced/video/set_like.json")
      response = @video.set_like("video_id", "like")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to set the privacy for a video" do
      stub_post("?privacy=privacy&video_id=video_id&api_key=12345&format=json&method=vimeo.videos.setPrivacy&auth_token=token&api_sig=e34654e6260ca22869a39c0213938e80", "advanced/video/set_privacy.json")
      response = @video.set_privacy("video_id", "privacy")
      
      assert_equal "ok", response["stat"]
    end

    should "be able to set the title of a video" do
      stub_post("?title=title&video_id=video_id&api_key=12345&format=json&method=vimeo.videos.setTitle&auth_token=token&api_sig=164cc69c87f1a460169875493623f9b4", "advanced/video/set_title.json")
      response = @video.set_title("video_id", "title")
      
      assert_equal "ok", response["stat"]
    end
    
    # comments
    
    should "be able to add a comment to a video" do
      stub_post("?video_id=video_id&api_key=12345&format=json&comment_text=comment_text&method=vimeo.videos.comments.addComment&auth_token=token&api_sig=cd01f8a9ed97bd68a4e1da8be337d9df", "advanced/video/add_comment.json")
      response = @video.add_comment("video_id", "comment_text")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to delete a comment" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.comments.deleteComment&auth_token=token&comment_id=comment_id&api_sig=aac80a3b34f94950f4000be7e337f1a8", "advanced/video/delete_comment.json")
      response = @video.delete_comment("video_id", "comment_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to edit a comment" do
      stub_post("?video_id=video_id&api_key=12345&format=json&comment_text=comment_text&method=vimeo.videos.comments.editComment&auth_token=token&comment_id=comment_id&api_sig=4f2c2503cd53ead8f1203b55241259c8", "advanced/video/edit_comment.json")
      response = @video.edit_comment("video_id", "comment_id", "comment_text")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get a list of comments" do
      stub_post("?video_id=video_id&api_key=12345&format=json&method=vimeo.videos.comments.getList&api_sig=ed4c2455eabcaad041d44b659b002ff8", "advanced/video/get_comments_list.json")
      response = @video.get_comments_list("video_id")
      
      assert_equal "ok", response["stat"]
    end
    
    # embed
    
    should "be able to set a preset" do
      stub_post("?preset_id=preset_id&video_id=video_id&api_key=12345&format=json&method=vimeo.videos.embed.getPresets&api_sig=ed4c2455eabcaad041d44b659b002ff8", "advanced/video/set_preset.json")
      response = @video.set_preset("preset_id", "video_id")
      
      assert_equal "ok", response["stat"]
    end

  end
end