require 'test_helper'

class BaseTest < Test::Unit::TestCase
  
  context "vimeo advanced base" do
    
    setup do
      @base = Vimeo::Advanced::Base.new("12345", "secret")
    end

    should "test something" do
      # TODO: add tests for authorization_url
    end

  end
end