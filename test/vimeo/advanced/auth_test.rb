require 'test_helper'

class AuthTest < Test::Unit::TestCase
  
  TOKEN = "12345"
  SECRET = "secret"

  context "vimeo advanced" do
    
    setup do
      @auth = Vimeo::Advanced::Base.new(TOKEN, SECRET)
    end
    
    should "recieve a valid OAuth url" do
      stub_custom_get("/oauth/request_token", "advanced/auth/request_token.txt")
      token = @auth.get_request_token
      assert_equal true, token.callback_confirmed?
      assert_equal "http://vimeo.com/oauth/authorize?oauth_token=#{TOKEN}", token.authorize_url
    end

    should "receive the user's credentials after checking the OAuth token" do
      stub_custom_get("/oauth/access_token", "advanced/auth/access_token.txt")
      stub_post("", "advanced/auth/check_access_token.json")
      auth = @auth.check_access_token
      assert_equal "token", auth["token"]
      assert_equal "write", auth["permission"]
    end

  end
end