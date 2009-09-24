require 'httpclient'
require 'json'

module Vimeo
  module Advanced

    class Upload < Vimeo::Advanced::Base

      # TODO: Make this work with either a JSON or an XML manifest.
      # Confirms the upload process.
      create_api_method :confirm,
                        "vimeo.videos.upload.confirm",
                        :required => [:auth_token, :ticket_id],
                        :unsigned => [:json_manifest]
      
      # "{\"files\":[{\"md5\":\"731f09145a1ea9ec9dad689de6fa0358\"}]}"

      # Returns the space and HD uploads left for a user.
      create_api_method :get_quota,
                        "vimeo.videos.upload.getQuota",
                        :required => [:auth_token]
                        
      # Returns an upload ticket.
      create_api_method :get_ticket,
                        "vimeo.videos.upload.getTicket",
                        :required => [:auth_token]

      # Upload +file+ to vimeo with +ticket_id+ and +auth_token+
      # Returns the json manifest necessary to confirm the upload.
      def upload(auth_token, file_path, ticket_id, end_point)
        params = {
          :auth_token => auth_token,
          :ticket_id  => ticket_id
        }
        params[:api_sig] = generate_api_sig params
        
        params.merge!({ :file_data => File.open(file_path) })
        
        client = HTTPClient.new
        response = client.post(end_point, params)
        md5 = response.content

        self.class.create_json_manifest(md5)
      end

      # TODO: Make this work with either json or xml manifest.
      # FIXME: Ticket id is required?
      # Verifies a file manifest.
      create_api_method :verify_manifest,
                        "vimeo.videos.upload.verifyManifest",
                        :required => [:auth_token, :ticket_id],
                        :unsigned => [:json_manifest]


      # TODO: Make this more flexible for split uploads?
      def self.create_json_manifest(md5s)
        { :files => md5s.map { |md5| { :md5 => md5 } } }.to_json
      end

    end # Upload
  end # Advanced
end # Vimeo