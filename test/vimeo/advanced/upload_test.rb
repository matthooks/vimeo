require 'test_helper'

class UploadTest < Test::Unit::TestCase

  context "vimeo advanced upload" do

    setup do
      @upload = Vimeo::Advanced::Upload.new("12345", "secret", :token => "token", :secret => "secret")
    end

    should "be able to get a user's quota" do
      stub_post("?api_key=12345&auth_token=token&format=json&api_sig=4eb2da55156fca5ab81bfe1a67a016ec&method=vimeo.videos.upload.getQuota", "advanced/upload/get_quota.json")
      response = @upload.get_quota

      assert_equal "888046", response["user"]["id"]
    end

    should "be able to get an upload ticket" do
      stub_post("?api_key=12345&auth_token=token&format=json&api_sig=0eabe7404e1c1fd22a269190c36e4093&method=vimeo.videos.upload.getTicket", "advanced/upload/get_ticket.json")
      response = @upload.get_ticket

      assert_equal "ticket_id", response["ticket"]["id"]
    end
  end
end