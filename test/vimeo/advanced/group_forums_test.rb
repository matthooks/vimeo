require 'test_helper'

class GroupForumsTest < Test::Unit::TestCase

  context "vimeo advanced group events" do
    
    setup do
      @group_forums = Vimeo::Advanced::GroupForums.new("12345", "secret", :token => "token", :secret => "secret")
    end

    should "be able to get a list comments for a group forum topic" do
      stub_post("?api_key=12345&topic_id=topic_id&group_id=group_id&format=json&method=vimeo.groups.forums.getTopicComments&api_sig=920d90a99e5af12339865b07314e2f49", "advanced/group_forums/get_topic_comments.json")
      response = @group_forums.get_topic_comments("group_id", "topic_id")
      
      assert_equal "5", response["comments"]["total"]
    end
    
    should "be able to get a list of group forum topics" do
      stub_post("?api_key=12345&group_id=group_id&format=json&method=vimeo.groups.forums.getTopics&api_sig=23ac4e1deac83f0ef175a8f4fdaf32a2", "advanced/group_forums/get_topics.json")
      response = @group_forums.get_topics("group_id")
      
      assert_equal "12", response["topics"]["total"]
    end

  end
end