require 'test_helper'

class BaseTest < Test::Unit::TestCase
  
  context "vimeo advanced base" do
    
    setup do
      @base = Vimeo::Advanced::Base.new("12345", "secret")
    end
    
    should "generate a valid web based authentication login link" do
      link = @base.web_login_link("delete")
      
      assert_equal "http://vimeo.com/services/auth/?api_key=12345&perms=delete&api_sig=b1a1a1f87a3a8bd84da1d3d464a72706", link
    end
    
    should "generate a valid desktop based authentication login link" do
      link = @base.desktop_login_link("delete", "67890")
      
      assert_equal "http://vimeo.com/services/auth/?api_key=12345&perms=delete&frob=67890&api_sig=deaee5c67d94df716ebe97d3bac180df", link
    end

  end
end