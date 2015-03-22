module Vimeo
  module Error
    class AccessTokenNotSet < Exception; end
    class NotFound < Exception; end
    class Unauthorized < Exception; end
    class Forbidden < Exception; end
    class BadRequest < Exception; end

    ERRORS = {
      400 => Vimeo::Error::BadRequest,
      401 => Vimeo::Error::Unauthorized,
      403 => Vimeo::Error::Forbidden,
      404 => Vimeo::Error::NotFound
    }
  end
end