require 'test_helper'

class ChannelTest < Test::Unit::TestCase

  context "vimeo advanced channel" do
    
    setup do
      @channel = Vimeo::Advanced::Channel.new("12345", "secret", :token => "token", :secret => "secret")
    end
    
    # context "making api calls" do
      
      should "be able to add a video to a channel" do
        stub_post("?auth_token=token&api_key=12345&api_sig=2065e5d5c0836428a2d2e945d160e504&format=json&method=vimeo.channels.addVideo&channel_id=channel_id&video_id=video_id", "advanced/channel/add_video.json")
        response = @channel.add_video("channel_id", "video_id")
        
        assert_equal "ok", response["stat"]
      end
      
      should "be able to get a list of all public channels" do
        stub_post("?api_key=12345&api_sig=12a13ded79ce7106a70b81ea2b3fb3f6&format=json&method=vimeo.channels.getAll", "advanced/channel/get_all.json")
        response = @channel.get_all
        
        assert_equal "44624", response["channels"]["total"]
      end
      
      should "be able to get information on a single channel" do
        stub_post("?api_key=12345&api_sig=4310c8352d8eb18f852b71444051bf34&format=json&method=vimeo.channels.getInfo&channel_id=channel_id", "advanced/channel/get_info.json")
        response = @channel.get_info("channel_id")
        
        assert_equal "Vimeo Gem Test", response["channel"]["name"]
      end
      
      should "be able to get a list of a channel's moderators" do
        stub_post("?api_key=12345&api_sig=aaaba50d397ca63d515788bcf571bd36&format=json&method=vimeo.channels.getModerators&channel_id=channel_id", "advanced/channel/get_moderators.json")
        response = @channel.get_moderators("channel_id")
        
        assert_equal "1", response["moderators"]["total"]
      end
      
      should "be able to get a list of a channel's subscribers" do
        stub_post("?api_key=12345&api_sig=6a3d504ba89107ac8f88a0c8ded7df78&format=json&method=vimeo.channels.getSubscribers&channel_id=channel_id", "advanced/channel/get_subscribers.json")
        response = @channel.get_subscribers("channel_id")
        
        assert_equal "1", response["subscribers"]["total"]
      end
      
      should "be able to get a list of videos in a channel" do
        stub_post("?api_key=12345&api_sig=e445038e6f8ad9cc32467e999c7f0e5b&format=json&method=vimeo.channels.getVideos&channel_id=channel_id", "advanced/channel/get_videos.json")
        response = @channel.get_videos("channel_id")
        
        assert_equal "1", response["videos"]["total"]
      end
      
      should "be able to remove a video from a channel" do
        stub_post("?video_id=video_id&api_key=12345&auth_token=token&format=json&api_sig=0d2fe81099d253f45b25c85033507a6f&method=vimeo.channels.removeVideo&channel_id=channel_id", "advanced/channel/remove_video.json")
        response = @channel.remove_video("channel_id", "video_id")
        
        assert_equal "ok", response["stat"]
      end
      
      should "be able to subscribe a user to a channel" do
        stub_post("?api_key=12345&auth_token=token&format=json&api_sig=cb0c7a3eed35bdd06b575d734e61b815&method=vimeo.channels.subscribe&channel_id=channel_id", "advanced/channel/subscribe.json")
        response = @channel.subscribe("channel_id")
        
        assert_equal "ok", response["stat"]
      end
      
      should "be able to unsubscribe a user from a channel" do
        stub_post("?api_key=12345&auth_token=token&format=json&api_sig=a6424de0df3134bf69390c9cb2e1653d&method=vimeo.channels.unsubscribe&channel_id=channel_id", "advanced/channel/unsubscribe.json")
        response = @channel.unsubscribe("channel_id")
        
        assert_equal "ok", response["stat"]
      end
      
    # end

  end
end