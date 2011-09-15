require 'test_helper'

class VimeoTest < Test::Unit::TestCase
  context "vimeo json parsing" do
    setup do
      @code = Proc.new do |req|
        %{require 'rubygems'; #{req} require './lib/vimeo'; print Vimeo.parse_json('{"a": "WORKING"}')['a'];}
          .gsub(%{"}, %{\\"})
      end
    end
    
    should "works with activesupport" do
      code = @code.call("require 'active_support';")
      assert_equal `ruby -e "#{code}"`, "WORKING"
    end
    
    should "works with yajl" do
      code = @code.call("require 'yajl/json_gem';")
      assert_equal `ruby -e "#{code}"`, "WORKING"
    end
    
    should "works with json gem" do
      code = @code.call("")
      assert_equal `ruby -e "#{code}"`, "WORKING"
    end
    
  end
  
end