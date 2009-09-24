require 'test_helper'

class VideoTest < Test::Unit::TestCase
  
  context "vimeo simple video" do
    
    setup do
      @video_id = "411684"
    end
    
    context "making api calls" do

      should "be able to get information about a video" do
        stub_get("/video/#{@video_id}.json", "simple/video/info.json")
        info = Vimeo::Simple::Video.info(@video_id).first
        
        assert_equal "411684", info["id"]
      end
      
    end
  end
end