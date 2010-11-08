require 'httpclient'
require 'json'

module Vimeo
  module Advanced

    class Upload < Vimeo::Advanced::Base

      # Check to make sure an upload ticket is still valid.
      create_api_method :check_ticket,
                        "vimeo.videos.upload.checkTicket",
                        :required => [:ticket_id]

      # Complete the upload process.
      create_api_method :complete,
                        "vimeo.videos.upload.complete",
                        :required => [:filename, :ticket_id]

      # Returns an upload ticket.
      create_api_method :get_ticket,
                        "vimeo.videos.upload.getTicket",
                        :optional => [:video_id]

      # Returns the space and HD uploads left for a user.
      create_api_method :get_quota,
                        "vimeo.videos.upload.getQuota"

      # Verify that the chunks were uploaded properly.
      create_api_method :verify_chunks,
                        "vimeo.videos.upload.verifyChunks",
                        :required => [:ticket_id]


      def upload_chunk(data, endpoint, options = {})
        pp @oauth_consumer.request(:post, endpoint, get_access_token, {}, options).body
      end

      # Upload +file+ to vimeo with +ticket_id+ and +auth_token+
      # Returns the json manifest necessary to confirm the upload.
      def upload(file_path)
        size      = File.size(file_path)
        basename  = File.basename(file_path)
        file      = File.open(file_path)
        file.binmode
        
        chunk_size  = 2 * 1024 * 1024       # 2 megabytes
        
        ticket_response = get_ticket
        pp ticket_response
        ticket      = ticket_response["ticket"]
        ticket_id   = ticket["id"]
        endpoint    = ticket["endpoint"] 
        
        chunk_count = (size.to_f / chunk_size.to_f).ceil
        chunk_sizes = {}
        
        chunk_count.times do |chunk_index|
          last = (chunk_index == chunk_count - 1)
          data = last ? file.read : file.read(chunk_size)
          
          chunk_sizes[chunk_index] = data.size
          upload_chunk(data, endpoint, :chunk_id => chunk_index, :ticket_id => ticket_id)
        end
        
        verification    = verify_chunks(:ticket_id => ticket_id)["ticket"]
        received_chunks = Hash[(verification["chunk"] || []).map do |chunk|
          [chunk["id"], chunk["size"]]
        end]
        
        chunk_sizes.all? do |id, size|
          received_chunks[id] == size
        end
        
        complete(:ticket_id => ticket_id, :filename => basename).tap do
          file.close
        end
      end
    end # Upload
  end # Advanced
end # Vimeo