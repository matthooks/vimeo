require 'test_helper'

class AlbumTest < Test::Unit::TestCase
  
  context "vimeo simple album" do
    
    setup do
      @album_id = "129077"
    end
    
    context "making api calls" do
      
      should "be able to see videos in an album" do
        stub_get("/album/#{@album_id}/videos.json", "simple/album/videos.json")
        videos = Vimeo::Simple::Album.videos(@album_id)
        
        assert_equal 20, videos.size
        first = videos.first
        assert_equal "Pause", first["title"]
      end

      should "be able to get information about an album" do
        stub_get("/album/#{@album_id}/info.json", "simple/album/info.json")
        info = Vimeo::Simple::Album.info(@album_id)
        
        assert_equal "129077", info["id"]
      end
      
    end
  end
end