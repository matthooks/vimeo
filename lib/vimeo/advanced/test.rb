module Vimeo
  module Advanced
    class Test < Vimeo::Advanced::Base

      # http://vimeo.com/api/docs/methods/vimeo.test.echo
      create_api_method :echo,
                        "vimeo.test.echo"

      # http://vimeo.com/api/docs/methods/vimeo.test.login
      create_api_method :login,
                        "vimeo.test.login"

      # http://vimeo.com/api/docs/methods/vimeo.test.null
      create_api_method :null,
                        "vimeo.test.null"

    end # Test
  end # Advanced
end # Vimeo