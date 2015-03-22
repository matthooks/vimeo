module Vimeo
  class Headers
    def initialize client
      @client = client
    end

    def request_headers
      headers = {}
      headers[:user_agent]    = user_agent
      headers[:authorization] = authorization
      headers[:content_type]  = 'application/vnd.vimeo.video+json'
      headers
    end

    protected
    def authorization
      "bearer #{@client.access_token}"
    end

    def user_agent
      "Ruby-Vimeo/#{Vimeo::VERSION} (https://github.com/matthooks/vimeo)"
    end
  end
end