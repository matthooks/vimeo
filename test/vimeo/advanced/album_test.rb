require 'test_helper'

class AlbumTest < Test::Unit::TestCase

  context "vimeo advanced album" do

    setup do
      @album = Vimeo::Advanced::Album.new("12345", "secret", :token => "token", :secret => "secret")
    end

    should "be able to add a video to an album" do
      stub_post("?oauth_nonce=3MFt5up5QljUQKJS8u9bOPzX9DXn3Xll1vdLLV2bwo&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=SgRuPWsG%2BSHGOdw6HVbfHtqSXsY%3D", "advanced/album/add_video.json")
      response = @album.add_video("album_id", "video_id")

      assert_equal "ok", response["stat"]
    end

    should "be able to create an album" do
      stub_post("?oauth_nonce=UkAfw5mrHZ2RiYl85vBxd9dGlpdOB1HiMs7ZXa7YGE&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=ZTGMAKrk4voVelv9Hzu2XzwlKbo%3D", "advanced/album/create.json")
      response = @album.create("title", "video_id")

      assert_equal "129683", response["album"]["id"]
    end

    should "be able to delete an album" do
      stub_post("?oauth_nonce=zyARBYynTJnBn9HiiKTQAGRVuDymj5kUkH72JPE9IBE&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=14SAeavDzDfbO6XY%2Bd4a05kJGGs%3D", "advanced/album/delete.json")
      response = @album.delete("album_id")

      assert_equal "ok", response["stat"]
    end

    should "be able to get a list of a user's albums" do
      stub_post("?oauth_nonce=4wZJ82yZnNtdnu4ccKaxBpAnyDLvf9xfiH4RrgRgK8o&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=KDczd%2F%2BEjPW64v0r6IbYL%2BJYcYs%3D", "advanced/album/get_all.json")
      response = @album.get_all("user_id")

      assert_equal "3", response["albums"]["total"]
    end

    should "be able to list the videos in an album" do
      stub_post("?oauth_nonce=yCIHyp8VXtFtxVzuKwMbHMwV7Z2eqKxDEeRTgOkwc&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=TwPJGzgvrYB4vOzyUKJueNTLMcI%3D", "advanced/album/get_videos.json")
      response = @album.get_videos("album_id")

      assert_equal "2", response["videos"]["total"]
    end

    should "be able to remove a video from an album" do
      stub_post("?oauth_nonce=fKXbUdxBFZoynegg9zzE0DS0AzhaHcNcOclSEo0&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=tztcS72SjTJxyioP3JN7KgQVUSI%3D", "advanced/album/remove_video.json")
      response = @album.remove_video("album_id", "video_id")

      assert_equal "ok", response["stat"]
    end

    should "be able to set the description of an album" do
      stub_post("?oauth_nonce=45zc84rri7doHXSDHtk5w3nDpfVU8EIj3do8z23tld8&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=xTB0pnxTlZsr1P42cpfFZ50EnkA%3D", "advanced/album/set_description.json")
      response = @album.set_description("album_id", "description")

      assert_equal "ok", response["stat"]
    end

    should "be able to set the password of an album" do
      stub_post("?oauth_nonce=ctucSZ9WBeP6lkmcmjT8tEmvQu5AJS7K5OZReGSzMk&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=7YcUkFMRryJAYRZGpBj47JFoFsQ%3D", "advanced/album/set_password.json")
      response = @album.set_password("album_id", "password")

      assert_equal "ok", response["stat"]
    end

    should "be able to set the title of an album" do
      stub_post("?oauth_nonce=nqVTjX53HqEvBR43v2qloK90TBJHbU7N7SdlisWHNGk&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=CpnakG4IBSfugNsi%2FUeVSN9zGu0%3D", "advanced/album/set_title.json")
      response = @album.set_title("album_id", "title")

      assert_equal "ok", response["stat"]
    end

    should "be able to get a list of a user's videos in his watch later album" do
      stub_post("?oauth_nonce=nqVTjX53HqEvBR43v2qloK90TBJHbU7N7SdlisWHNGk&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=CpnakG4IBSfugNsi%2FUeVSN9zGu0%3D", "advanced/album/get_watch_later.json")
      response = @album.get_watch_later

      assert_equal "3", response["total"]
    end

    should "be able to add a video to a user's watch later album" do
      stub_post("?oauth_nonce=nqVTjX53HqEvBR43v2qloK90TBJHbU7N7SdlisWHNGk&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=CpnakG4IBSfugNsi%2FUeVSN9zGu0%3D", "advanced/album/add_to_watch_later.json")
      response = @album.add_to_watch_later("video_id")

      assert_equal "ok", response["stat"]
    end

    should "be able to remove a video from a user's watch later album" do
      stub_post("?oauth_nonce=nqVTjX53HqEvBR43v2qloK90TBJHbU7N7SdlisWHNGk&oauth_signature_method=HMAC-SHA1&oauth_token=token&oauth_timestamp=1261345197&oauth_consumer_key=12345&oauth_version=1.0&oauth_signature=CpnakG4IBSfugNsi%2FUeVSN9zGu0%3D", "advanced/album/remove_from_watch_later.json")
      response = @album.remove_from_watch_later("video_id")

      assert_equal "ok", response["stat"]
    end

  end
end