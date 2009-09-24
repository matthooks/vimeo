require 'test_helper'

class ChannelTest < Test::Unit::TestCase
  
  context "vimeo simple channel" do
    
    setup do
      @channel_name = "canon7d"
    end
    
    context "making api calls" do
      
      should "be able to see videos in a channel" do
        stub_get("/channel/#{@channel_name}/videos.json", "simple/channel/videos.json")
        videos = Vimeo::Simple::Channel.videos(@channel_name)
        
        assert_equal 20, videos.size
        first = videos.first
        assert_equal "7D Test 03", first["title"]
      end

      should "be able to get information about a channel" do
        stub_get("/channel/#{@channel_name}/info.json", "simple/channel/info.json")
        info = Vimeo::Simple::Channel.info(@channel_name)
        
        assert_equal "58337", info["id"]
      end
      
    end
  end
end