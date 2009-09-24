module Vimeo
  module Advanced

    class Test < Vimeo::Advanced::Base
      
      # An echo test. Echoes all parameters.
      # Options can be anything except method, api_key,
      # and api_sig -- if any of these options are
      # present they will be overwritten by the proper
      # values.
      create_api_method :echo,
                        "vimeo.test.echo"

      # def echo(options={})
      #   options.merge!(:method => "vimeo.test.echo")
      #   api_sig = generate_api_sig options
      #   options.merge!(:api_sig => api_sig)
      #   self.class.post("/api/rest", :query => options)
      # end

      # Tests if the user associated to this token
      # is able to make authenticated calls.      
      create_api_method :login,
                        "vimeo.test.login",
                        :required => [:auth_token]


      # A simple ping test.
      create_api_method :null,
                        "vimeo.test.null",
                        :required => [:auth_token]
      
    end

  end # Advanced
end # Vimeo