require 'test_helper'

class AlbumTest < Test::Unit::TestCase

  context "vimeo advanced album" do
    
    setup do
      @album = Vimeo::Advanced::Album.new("12345", "secret")
    end
    
    # context "making api calls" do
      
      should "be able to add a video to an album" do
        # @album.stubs(:generate_api_sig).returns("287d134442136f37d967243f93028fc3")
        stub_post("?api_key=12345&video_id=video_id&album_id=album_id&auth_token=token&format=json&api_sig=287d134442136f37d967243f93028fc3&method=vimeo.albums.addVideo", "advanced/album/add_video.json")
        response = @album.add_video("token", "album_id", "video_id")
        
        assert_equal "ok", response["stat"]
      end
      
      should "be able to create an album" do
        # @album.stubs(:generate_api_sig).returns("0c5ba48ca249a0e4b3e5d13adbbe48ff")
        stub_post("?api_key=12345&video_id=video_id&auth_token=token&format=json&api_sig=0c5ba48ca249a0e4b3e5d13adbbe48ff&title=title&method=vimeo.albums.create", "advanced/album/create.json")
        response = @album.create("token", "title", "video_id")
        
        assert_equal "129683", response["album"]["id"]
      end
      
      should "be able to delete an album" do
        # @album.stubs(:generate_api_sig).returns("71787010d4225ec36036c8037cc397c1")
        stub_post("?api_key=12345&format=json&album_id=album_id&auth_token=token&api_sig=71787010d4225ec36036c8037cc397c1&method=vimeo.albums.delete", "advanced/album/delete.json")
        response = @album.delete("token", "album_id")
        
        assert_equal "ok", response["stat"]
      end
      
      should "be able to get a list of a user's albums" do
        # @album.stubs(:generate_api_sig).returns("5103ce16eece56247c8208100f3a0606")
        stub_post("?api_key=12345&format=json&api_sig=5103ce16eece56247c8208100f3a0606&method=vimeo.albums.getAll&user_id=user_id", "advanced/album/get_all.json")
        response = @album.get_all("user_id")
        
        assert_equal "3", response["albums"]["total"]
      end
      
      should "be able to list the videos in an album" do
        # @album.stubs(:generate_api_sig).returns("91027cc9465a37a1cc69bcd9714fe308")
        stub_post("?format=json&api_key=12345&album_id=album_id&method=vimeo.albums.getVideos&auth_token=token&api_sig=91027cc9465a37a1cc69bcd9714fe308", "advanced/album/get_videos.json")
        response = @album.get_videos("token", "album_id")
        
        assert_equal "2", response["videos"]["total"]
      end
      
      should "be able to remove a video from an album" do
        # @album.stubs(:generate_api_sig).returns("b87c3ccea7fe3f64a76a4a9eeb37446e")
        stub_post("?album_id=album_id&api_key=12345&auth_token=token&api_sig=b87c3ccea7fe3f64a76a4a9eeb37446e&format=json&method=vimeo.albums.removeVideo&video_id=video_id", "advanced/album/remove_video.json")
        response = @album.remove_video("token", "album_id", "video_id")
        
        assert_equal "ok", response["stat"]
      end
      
      should "be able to set the description of an album" do
        # @album.stubs(:generate_api_sig).returns("1cbba27b53a83446bf94c856ae60f3ed")
        stub_post("?album_id=album_id&api_key=12345&auth_token=token&api_sig=1cbba27b53a83446bf94c856ae60f3ed&format=json&method=vimeo.albums.setDescription&description=description", "advanced/album/set_description.json")
        response = @album.set_description("token", "album_id", "description")
        
        assert_equal "ok", response["stat"]
      end
      
      should "be able to set the password of an album" do
        # @album.stubs(:generate_api_sig).returns("a31a865876d15eb23c4bae6de460c132")
        stub_post("?album_id=album_id&api_key=12345&auth_token=token&password=password&api_sig=a31a865876d15eb23c4bae6de460c132&format=json&method=vimeo.albums.setPassword", "advanced/album/set_password.json")
        response = @album.set_password("token", "album_id", "password")
        
        assert_equal "ok", response["stat"]
      end
      
      should "be able to set the title of an album" do
        # @album.stubs(:generate_api_sig).returns("b4e72980c9c6aacabdd341cb0bf535ba")
        stub_post("?album_id=album_id&api_key=12345&auth_token=token&api_sig=b4e72980c9c6aacabdd341cb0bf535ba&format=json&title=title&method=vimeo.albums.setTitle", "advanced/album/set_title.json")
        response = @album.set_title("token", "album_id", "title")
        
        assert_equal "ok", response["stat"]
      end
      
    # end

  end
end