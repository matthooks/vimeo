module Vimeo
  module Advanced
    class GroupForums < Vimeo::Advanced::Base

      # Returns a list of comments for a group forum topic.
      create_api_method :get_topic_comments,
                        "vimeo.groups.forums.getTopicComments",
                        :required => [:group_id, :topic_id],
                        :optional => [:page, :per_page]

      # Returns a list of all group forum topics.
      create_api_method :get_topics,
                        "vimeo.groups.forums.getTopics",
                        :required => [:group_id],
                        :optional => [:page, :per_page]

    end # GroupForums
  end # Advanced
end # Vimeo