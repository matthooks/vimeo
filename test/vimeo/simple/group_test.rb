require 'test_helper'

class GroupTest < Test::Unit::TestCase
  
  context "vimeo simple group" do
    
    setup do
      @group_name = "worldtour"
    end
    
    context "making api calls" do
      
      should "be able to see videos in a group" do
        stub_get("/group/#{@group_name}/videos.json", "simple/group/videos.json")
        videos = Vimeo::Simple::Group.videos(@group_name)
        
        assert_equal 10, videos.size
        first = videos.first
        assert_equal "Vimeo Offline Party: London", first["title"]
      end
      
      should "be able to see users in a group" do
        # This fixture file has been shortened.
        stub_get("/group/#{@group_name}/users.json", "simple/group/users.json")
        users = Vimeo::Simple::Group.users(@group_name)
        
        assert_equal 1, users.size
        first = users.first
        assert_equal "cris", first["display_name"]
      end

      should "be able to get information about a group" do
        stub_get("/group/#{@group_name}/info.json", "simple/group/info.json")
        info = Vimeo::Simple::Group.info(@group_name)
        
        assert_equal "20067", info["id"]
      end
      
    end
  end
end