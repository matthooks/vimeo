require 'test_helper'

class GroupEventsTest < Test::Unit::TestCase

  context "vimeo advanced group events" do
    
    setup do
      @group_events = Vimeo::Advanced::GroupEvents.new("12345", "secret", :token => "token", :secret => "secret")
    end

    should "be able to get a list of events by month" do
      stub_post("?api_key=12345&group_id=worldtour&format=json&method=vimeo.groups.events.getMonth&api_sig=8d02a348670d7e72ec1c2bd5bee76b10", "advanced/group_events/get_month.json")
      response = @group_events.get_month("worldtour")
      
      assert_equal "3", response["events"]["total"]
    end
    
    should "be able to get a list of events past" do
      stub_post("?api_key=12345&group_id=worldtour&format=json&method=vimeo.groups.events.getPast&api_sig=51807614d2ffda7e04d13a015b2757d4", "advanced/group_events/get_past.json")
      response = @group_events.get_past("worldtour")
      
      assert_equal "3", response["events"]["total"]
    end
    
    should "be able to get a list of events upcoming" do
      stub_post("?api_key=12345&group_id=worldtour&format=json&method=vimeo.groups.events.getUpcoming&api_sig=17035db6a6f58e6c1370ee876bf71c70", "advanced/group_events/get_upcoming.json")
      response = @group_events.get_upcoming("worldtour")
      
      assert_equal "3", response["events"]["total"]
    end

  end
end