module Vimeo
  # normalized exception that all exceptions inherit from
  class Exception < ::Exception; end

  module Error
    # raised depending on the http status
    class AccessTokenNotSet < Vimeo::Exception; end
    class NotFound < Vimeo::Exception; end
    class Unauthorized < Vimeo::Exception; end
    class Forbidden < Vimeo::Exception; end
    class BadRequest < Vimeo::Exception; end
    class Unavaliable < Vimeo::Exception; end
    # raised if the response from Vimeo is invalid
    class InvalidResponse < Vimeo::Exception; end

    ERRORS = {
      400 => Vimeo::Error::BadRequest,
      401 => Vimeo::Error::Unauthorized,
      403 => Vimeo::Error::Forbidden,
      404 => Vimeo::Error::NotFound,
      500 => Vimeo::Error::Unavaliable
    }
  end
end