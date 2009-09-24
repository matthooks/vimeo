require 'test_helper'

class AuthTest < Test::Unit::TestCase
  
  context "vimeo advanced auth" do
    
    setup do
      @auth = Vimeo::Advanced::Auth.new("12345", "secret")
    end
    
    context "making api calls" do
      
      should "check an auth token" do
        stub_post("?format=json&api_key=12345&method=vimeo.auth.checkToken&auth_token=token&api_sig=868c600fda7509ae9d92bff9edc74a3a", "advanced/auth/check_token.json")
        auth = @auth.check_token("token")
        
        assert_equal "token", auth["auth"]["token"]
      end
      
      should "get an auth frob" do
        stub_post("?api_key=12345&format=json&method=vimeo.auth.getFrob&api_sig=de431996ca0bb2597d63aa2d5d3d1255", "advanced/auth/get_frob.json")
        frob = @auth.get_frob
        
        assert_equal "frob", frob["frob"]
      end
      
      should "get an auth token" do
        stub_post("?format=json&frob=frob&api_key=12345&method=vimeo.auth.getToken&api_sig=4f60bcf463619418baa3d97ba900f083", "advanced/auth/get_token.json")
        auth = @auth.get_token("frob")
        
        assert_equal "token", auth["auth"]["token"]
      end
      
    end

  end
end