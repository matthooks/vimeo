require 'test_helper'

class TestTest < Test::Unit::TestCase

  context "vimeo advanced test" do
    
    setup do
      @test = Vimeo::Advanced::Test.new("12345", "secret", :token => "token", :secret => "secret")
    end

    should "be able to get an echo" do
      stub_post("?api_key=12345&format=json&api_sig=6f913caf4fd018a0dd48400f6ac07439&method=vimeo.test.echo", "advanced/test/echo.json")
      response = @test.echo
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to test if a user is logged in" do
      stub_post("?api_key=12345&auth_token=token&format=json&api_sig=9753d04b7b5b3c47101aace3f314ed84&method=vimeo.test.login", "advanced/test/login.json")
      response = @test.login
      
      assert_equal "matthooks", response["user"]["username"]
    end
    
    should "be able to ping the Vimeo advanced API" do
      stub_post("?api_key=12345&auth_token=token&format=json&api_sig=5f45b34d1e7078636f5386b8db7408ee&method=vimeo.test.null", "advanced/test/null.json")
      response = @test.null
      
      assert_equal "ok", response["stat"]
    end

  end
end