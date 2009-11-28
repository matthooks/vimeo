require 'test_helper'

class UploadTest < Test::Unit::TestCase

  context "vimeo advanced upload" do
    
    setup do
      @upload = Vimeo::Advanced::Upload.new("12345", "secret")
    end

    should "be able confirm an upload" do
      stub_post("?api_key=12345&ticket_id=ticket_id&format=json&auth_token=token&api_sig=576b41966709651aead8754b3c5d370d&method=vimeo.videos.upload.confirm", "advanced/upload/confirm.json")
      response = @upload.confirm("ticket_id", "json_manifest")

      assert_equal "ticket_id", response["ticket"]["id"]
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

    # TODO: Stub out the HTTPClient calls correctly since FakeWeb doesn't work here.
    # should "be able to upload a file to vimeo" do
    #   HTTPClient.any_instance.stubs(:post)
    #   file_path = File.expand_path(File.dirname(__FILE__) + "../../../fixtures/advanced/upload/sample_iTunes.mov")
    #   response = @upload.upload(file_path, "ticket_id", "http:\/\/67.202.6.15\/upload_multi?ticket_id=ticket_id")
    # 
    #   assert_equal "MD5", response
    # end
    
    # TODO: Make sure this manifest fixture file is right.
    should "be able to verify a file manifest" do
      stub_post("?api_key=12345&ticket_id=ticket_id&format=json&auth_token=token&api_sig=3b1c022ba0be09e5901bd91fb5a4426c&method=vimeo.videos.upload.verifyManifest", "advanced/upload/verify_manifest.json")
      response = @upload.verify_manifest("ticket_id", "json_manifest")
      
      assert_equal "ticket_id", response["ticket"]["id"]
    end

  end
end