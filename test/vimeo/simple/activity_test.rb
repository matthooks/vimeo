require 'test_helper'

class ActivityTest < Test::Unit::TestCase
  
  context "vimeo simple activity" do
    
    setup do
      @username = "brad" # Brad Dougherty, Vimeo Staffer
    end
    
    context "making api calls" do
      
      should "be able to get activity by the user" do
        stub_get("/activity/#{@username}/user_did.json", "simple/activity/user_did.json")
        activities = Vimeo::Simple::Activity.user_did(@username)
        
        assert_equal 20, activities.size
        first = activities.first
        assert_equal "add_comment_forum", first["type"]
      end

      should "be able to get activity on the user" do
        stub_get("/activity/#{@username}/happened_to_user.json", "simple/activity/happened_to_user.json")
        activities = Vimeo::Simple::Activity.happened_to_user(@username)
        
        assert_equal 20, activities.size
        first = activities.first
        assert_equal "like", first["type"]
      end

      should "be able to get activity by the user's contacts" do
        stub_get("/activity/#{@username}/contacts_did.json", "simple/activity/contacts_did.json")
        activities = Vimeo::Simple::Activity.contacts_did(@username)
        
        assert_equal 20, activities.size
        first = activities.first
        assert_equal "add_comment_forum", first["type"]
      end

      should "be able to get activity on the user's contacts" do
        stub_get("/activity/#{@username}/happened_to_contacts.json", "simple/activity/happened_to_contacts.json")
        activities = Vimeo::Simple::Activity.happened_to_contacts(@username)
        
        assert_equal 20, activities.size
        first = activities.first
        assert_equal "like", first["type"]
      end

      should "be able to get activity by everyone" do
        stub_get("/activity/#{@username}/everyone_did.json", "simple/activity/everyone_did.json")
        activities = Vimeo::Simple::Activity.everyone_did(@username)
        
        assert_equal 20, activities.size
        first = activities.first
        assert_equal "upload", first["type"]
      end
      
    end
  end
end