require 'test_helper'

class ContactTest < Test::Unit::TestCase

  context "vimeo advanced channel" do
    
    setup do
      @contact = Vimeo::Advanced::Contact.new("12345", "secret", :token => "token", :secret => "secret")
    end
      
    should "be able to get a list of contacts for a specified user" do
      stub_post("?api_key=12345&api_sig=09ce758b4a0c53840fe5bcb2676219da&format=json&user_id=matthooks&method=vimeo.contacts.getAll", "advanced/contact/get_all.json")
      response = @contact.get_all("matthooks")
      
      assert_equal "3", response["contacts"]["total"]
    end
    
    should "be able to get a list of mutual contacts for a specified user" do
      stub_post("?api_key=12345&api_sig=6efaa075604a7274d396f9e108eb7589&format=json&user_id=matthooks&method=vimeo.contacts.getMutual", "advanced/contact/get_mutual.json")
      response = @contact.get_mutual("matthooks")
      
      assert_equal "2", response["contacts"]["total"]
    end
    
    should "be able to get a list of the user's contacts who are currently online" do
      stub_post("?api_key=12345&api_sig=2218151ed4ed65cbf35c48bd041b663c&format=json&method=vimeo.contacts.getOnline", "advanced/contact/get_online.json")
      response = @contact.get_online
      
      assert_equal "1", response["contacts"]["total"]
    end
    
    should "be able to get a list of the users who have added a specific user as a contact" do
      stub_post("?api_key=12345&api_sig=ecb3d220d66c3d0b9e357c59e2ae622f&format=json&user_id=matthooks&method=vimeo.contacts.getWhoAdded", "advanced/contact/get_who_added.json")
      response = @contact.get_who_added("matthooks")
      
      assert_equal "3", response["contacts"]["total"]
    end

  end
end