require 'test_helper'

class PersonTest < Test::Unit::TestCase

  context "vimeo advanced person" do
    
    setup do
      @person = Vimeo::Advanced::Person.new("12345", "secret", :token => "token", :secret => "secret")
    end

    should "be able to add a contact" do
      stub_post("?api_key=12345&auth_token=token&format=json&api_sig=da78079bb036f66f6ccca31014650371&method=vimeo.people.addContact&user_id=user_id", "advanced/person/add_contact.json")
      response = @person.add_contact("user_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get add a subscription" do
      stub_post("?api_key=12345&types=likes&auth_token=token&format=json&api_sig=f02dae35e4eb7a7e2ca0ad9c026ad311&method=vimeo.people.addSubscription&user_id=user_id", "advanced/person/add_subscription.json")
      response = @person.add_subscription("user_id", "likes")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to find a user by email" do
      stub_post("?api_key=12345&format=json&api_sig=1b772e7074bffdff17fa94a310e6b496&method=vimeo.people.findByEmail&user_id=email", "advanced/person/find_by_email.json")
      response = @person.find_by_email("email")
      
      assert_equal "matthooks", response["user"]["username"]
    end
    
    should "be able to get the remaining number of hd embeds" do
      stub_post("?api_key=12345&auth_token=token&format=json&api_sig=3ac165886cbfc8dbf0f5a1cbc49c2943&method=vimeo.people.getHDEmbeds", "advanced/person/get_hd_embeds.json")

      assert_raise(Vimeo::Advanced::RequestFailed) do
        response = @person.get_hd_embeds
      end
    end
    
    should "be able to get a user's info" do
      stub_post("?api_key=12345&format=json&api_sig=c9e114639756433a11867c754819065f&method=vimeo.people.getInfo&user_id=matthooks", "advanced/person/get_info.json")
      response = @person.get_info("matthooks")
      
      assert_equal "matthooks", response["person"]["username"]
    end
    
    should "be able to get a user's portrait urls" do
      stub_post("?api_key=12345&format=json&api_sig=6f70c7ca870c127c07d6fcbdd96b2d74&method=vimeo.people.getPortraitUrls&user_id=matthooks", "advanced/person/get_portrait_urls.json")
      response = @person.get_portrait_urls("matthooks")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to get remove a user from your contacts" do
      stub_post("?api_key=12345&auth_token=token&format=json&api_sig=0d21943588aae94c65575f4a49e05b63&method=vimeo.people.removeContact&user_id=user_id", "advanced/person/remove_contact.json")
      response = @person.remove_contact("user_id")
      
      assert_equal "ok", response["stat"]
    end
    
    should "be able to remove you from a subscription" do
      stub_post("?api_key=12345&types=likes&auth_token=token&format=json&api_sig=8f63f6fc9988250db4ff4d92bbb2b9c1&method=vimeo.people.removeSubscription&user_id=user_id", "advanced/person/remove_subscription.json")
      response = @person.remove_subscription("user_id", "likes")
      
      assert_equal "ok", response["stat"]
    end

  end
end