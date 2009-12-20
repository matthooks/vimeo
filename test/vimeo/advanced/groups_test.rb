require 'test_helper'

class GroupTest < Test::Unit::TestCase

  context "vimeo advanced group" do
    
    setup do
      @group = Vimeo::Advanced::Group.new("12345", "secret", :token => "token", :secret => "secret")
    end

    should "be able to add a video to a group" do
      stub_post("?video_id=video_id&api_key=12345&auth_token=token&format=json&api_sig=e37ae534be5b03cdc1cb9ed28ed99317&method=vimeo.groups.addVideo&group_id=group_id", "advanced/group/add_video.json")
      response = @group.add_video("group_id", "video_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get all public groups" do
      stub_post("?api_key=12345&api_sig=d3b21ed184e1924c31b2db6e7253adb0&format=json&method=vimeo.groups.getAll", "advanced/group/get_all.json")
      response = @group.get_all
      
      assert_equal "20619", response["groups"]["total"]
    end
    
    should "be able to get all files for a group" do
      stub_post("?api_key=12345&api_sig=a6fe673f65e0f4549c095e115e7cf853&format=json&group_id=group_id&method=vimeo.groups.getFiles", "advanced/group/get_files.json")
      response = @group.get_files("group_id")
      
      assert_equal "6", response["files"]["total"]
    end
    
    should "be able to get information about a group" do
      stub_post("?api_key=12345&api_sig=ae2c232bc3543549a9f036bc1ad61724&format=json&group_id=group_id&method=vimeo.groups.getInfo", "advanced/group/get_info.json")
      response = @group.get_info("group_id")
      
      assert_equal "1", response["groups"]["total"]
    end
    
    should "be able to get the members of a group" do
      stub_post("?api_key=12345&api_sig=c0b30f51a88dcc1ad951019c23cd114f&format=json&group_id=group_id&method=vimeo.groups.getMembers", "advanced/group/get_members.json")
      response = @group.get_members("group_id")
      
      assert_equal "418", response["members"]["total"]
    end
    
    should "be able to get the moderators of a group" do
      stub_post("?api_key=12345&api_sig=21798438b1718d7f51ea2b40c72f5f69&format=json&group_id=group_id&method=vimeo.groups.getModerators", "advanced/group/get_moderators.json")
      response = @group.get_moderators("group_id")
      
      assert_equal "1", response["moderators"]["total"]
    end
    
    should "be able to get the video comments of a group's video" do
      stub_post("?api_key=12345&api_sig=502274981e673cc19a9fb2561a13d572&format=json&group_id=group_id&method=vimeo.groups.getVideoComments&video_id=video_id", "advanced/group/get_video_comments.json")
      response = @group.get_video_comments("group_id", "video_id")
      
      assert_equal "2", response["comments"]["total"]
    end
    
    should "be able to get a list of a group's videos" do
      stub_post("?api_key=12345&api_sig=4927ef1c0a49069020d6ae6ce8c98683&format=json&group_id=group_id&method=vimeo.groups.getVideos", "advanced/group/get_videos.json")
      response = @group.get_videos("group_id")
      
      assert_equal "10", response["videos"]["total"]
    end
    
    should "be able to join a group" do
      stub_post("?api_key=12345&auth_token=token&format=json&api_sig=99114c85438cb286adbfba05a1b921ed&method=vimeo.groups.join&group_id=group_id", "advanced/group/join.json")
      response = @group.join("group_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to leave a group" do
      stub_post("?api_key=12345&auth_token=token&format=json&api_sig=a465333190c89f9eedc06a148db018be&method=vimeo.groups.leave&group_id=group_id", "advanced/group/leave.json")
      response = @group.leave("group_id")
      
      assert_equal "ok", response["stat"]
    end

  end
end