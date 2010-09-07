require 'test_helper'

class BaseTest < Test::Unit::TestCase
  
  context "vimeo advanced base" do
    
    setup do
      @base = Vimeo::Advanced::Base.new("12345", "secret")
    end
    
    should "allow camel-cased methods" do
      stub_custom_get("/oauth/access_token", "advanced/auth/access_token.txt")
      stub_post("", "advanced/auth/check_access_token.json")
      
      [:check_access_token, :checkAccessToken].each do |method|
        @base.send method
      end
    end

  end
end