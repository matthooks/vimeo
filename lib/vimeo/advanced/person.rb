module Vimeo
  module Advanced

    class Person < Vimeo::Advanced::Base

      def find_by_user_name(username)
        sig_options = {
          :username => username,
          :method => "vimeo.people.findByUserName"
        }

        make_request sig_options
      end

      def find_by_email(find_email)
        sig_options = {
          :find_email => find_email,
          :method => "vimeo.people.findByEmail"
        }

        make_request sig_options
      end

      def get_info(user_id)
        sig_options = {
          :user_id => user_id,
          :method => "vimeo.people.getInfo"
        }

        make_request sig_options
      end

      # TODO: This seems to be returning nil from Vimeo... not implemented?
      def get_portrait_url(user_id, options={})
        size = options[:size]

        sig_options = {
          :user_id => user_id,
          :method => "vimeo.people.getPortraitUrl"
        }
        sig_options.merge! :size => size unless size.nil?

        make_request sig_options
      end

      # TODO: Not working on Vimeo's side
      def add_contact(user_id, auth_token)
        sig_options = {
          :user_id => user_id,
          :auth_token => auth_token,
          :method => "vimeo.people.addContact"
        }

        make_request sig_options
      end

      # TODO: Not working on Vimeo's side
      def remove_contact(user_id, auth_token)
        sig_options = {
          :user_id => user_id,
          :auth_token => auth_token,
          :method => "vimeo.people.removeContact"
        }

        make_request sig_options
      end

      def get_upload_status(user_id, auth_token)
        sig_options = {
          :user_id => user_id,
          :auth_token => auth_token,
          :method => "vimeo.people.getUploadStatus"
        }

        make_request sig_options
      end

      # TODO: Verify input for type?
      def add_subscription(user_id, type, auth_token)
        sig_options = {
          :user_id => user_id,
          :type => type,
          :auth_token => auth_token,
          :method => "vimeo.people.addSubscription"
        }

        make_request sig_options
      end

      # TODO: Verify input for type?
      def remove_subscription(user_id, type, auth_token)
        sig_options = {
          :user_id => user_id,
          :type => type,
          :auth_token => auth_token,
          :method => "vimeo.people.removeSubscription"
        }

        make_request sig_options
      end

    end

  end # Advanced
end # Vimeo