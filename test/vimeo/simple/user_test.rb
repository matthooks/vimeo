require 'test_helper'

class UserTest < Test::Unit::TestCase

  context "vimeo simple user" do

    setup do
      @user_name = "blakewhitman"
    end

    context "making api calls" do

      should "be able to get info for a user" do
        stub_get("/#{@user_name}/info.json", "simple/user/info.json")
        info = Vimeo::Simple::User.info(@user_name)

        assert_equal "Blake Whitman", info["display_name"]
      end

      should "be able to get videos created by a user" do
        stub_get("/#{@user_name}/videos.json?page=1", "simple/user/videos.json")
        videos = Vimeo::Simple::User.videos(@user_name)

        assert_equal 20, videos.size
        first = videos.first
        assert_equal "pulse", first["title"]
      end

      should "be able to get videos a user likes" do
        stub_get("/#{@user_name}/likes.json", "simple/user/likes.json")
        videos = Vimeo::Simple::User.likes(@user_name)

        assert_equal 20, videos.size
        first = videos.first
        assert_equal "Seed", first["title"]
      end

      should "be able to get videos that a user appears in" do
        stub_get("/#{@user_name}/appears_in.json", "simple/user/appears_in.json")
        videos = Vimeo::Simple::User.appears_in(@user_name)

        assert_equal 20, videos.size
        first = videos.first
        assert_equal "Vimeo Offline Party: London", first["title"]
      end

      should "be able to get videos that a user appears in and/or created" do
        stub_get("/#{@user_name}/all_videos.json", "simple/user/all_videos.json")
        videos = Vimeo::Simple::User.all_videos(@user_name)

        assert_equal 20, videos.size
        first = videos.first
        assert_equal "Vimeo Offline Party: London", first["title"]
      end

      should "be able to get videos a user is subscribed to" do
        stub_get("/#{@user_name}/subscriptions.json", "simple/user/subscriptions.json")
        videos = Vimeo::Simple::User.subscriptions(@user_name)

        assert_equal 20, videos.size
        first = videos.first
        assert_equal "TIDES - HD", first["title"]
      end

      should "be able to get albums a user has created" do
        stub_get("/#{@user_name}/albums.json", "simple/user/albums.json")
        albums = Vimeo::Simple::User.albums(@user_name)

        assert_equal 30, albums.size
        first = albums.first
        assert_equal "Amigos", first["title"]
      end

      should "be able to get channels a user has created and subscribed to" do
        stub_get("/#{@user_name}/channels.json", "simple/user/channels.json")
        channels = Vimeo::Simple::User.channels(@user_name)

        assert_equal 195, channels.size
        first = channels.first
        assert_equal "01SHORTFILM   ______ Only the best, international, award-winning, CINEMATIC shortfilms", first["name"]
      end

      should "be able to get groups that a user either created and/or joined" do
        stub_get("/#{@user_name}/groups.json", "simple/user/groups.json")
        groups = Vimeo::Simple::User.groups(@user_name)

        assert_equal 97, groups.size
        first = groups.first
        assert_equal "3D Animation", first["name"]
      end

      should "be able to get videos that a user's contacts created" do
        stub_get("/#{@user_name}/contacts_videos.json", "simple/user/contacts_videos.json")
        videos = Vimeo::Simple::User.contacts_videos(@user_name)

        assert_equal 20, videos.size
        first = videos.first
        assert_equal "Star Wars Uncut - Scene 90", first["title"]
      end

      should "be able to get videos that a user's contacts liked" do
        stub_get("/#{@user_name}/contacts_like.json", "simple/user/contacts_like.json")
        videos = Vimeo::Simple::User.contacts_like(@user_name)

        assert_equal 20, videos.size
        first = videos.first
        assert_equal "Jaybilizer 3000 Camera Stabilizer Shooting Techniques and Montage", first["title"]
      end

    end
  end
end