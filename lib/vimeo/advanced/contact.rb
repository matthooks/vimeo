module Vimeo
  module Advanced

    class Contact < Vimeo::Advanced::Base

      def get_list(user_id)
        sig_options = {
          :user_id => user_id,
          :method => "vimeo.contacts.getList"
        }

        make_request sig_options
      end

    end

  end # Advanced
end # Vimeo