module Vimeo
  module Upload
    include Vimeo::Helpers

    def upload method, file, ticket
      raise Vimeo::InvalidUploadTicket unless ticket.has_key? :ticket_id
      case method
      when :streaming
        stream_upload(file, ticket)
      when :post
        post_upload(file, ticket)
      else
        raise Vimeo::InvalidUploadMethod
      end
    end
  end
end
