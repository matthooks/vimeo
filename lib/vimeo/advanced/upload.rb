module Vimeo
  module Advanced

    class Upload < Vimeo::Advanced::Base

      def get_upload_ticket(auth_token)
        sig_options = {
          :auth_token => auth_token,
          :method => "vimeo.videos.getUploadTicket"
        }

        make_request sig_options
      end

      def check_upload_status(ticket_id, auth_token)
        sig_options = {
          :ticket_id => ticket_id,
          :auth_token => auth_token,
          :method => "vimeo.videos.checkUploadStatus"
        }

        make_request sig_options
      end

    end

  end # Advanced
end # Vimeo