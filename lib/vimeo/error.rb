module Vimeo
  class Exception < ::Exception; end

  module Error
    class AccessTokenNotSet < Vimeo::Exception; end
    class NotFound < Vimeo::Exception; end
    class Unauthorized < Vimeo::Exception; end
    class Forbidden < Vimeo::Exception; end
    class BadRequest < Vimeo::Exception; end

    ERRORS = {
      400 => Vimeo::Error::BadRequest,
      401 => Vimeo::Error::Unauthorized,
      403 => Vimeo::Error::Forbidden,
      404 => Vimeo::Error::NotFound
    }
  end
end