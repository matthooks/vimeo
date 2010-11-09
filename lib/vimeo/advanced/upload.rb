require 'json'

module Vimeo
  module Advanced

    class Upload < Vimeo::Advanced::Base
      class UploadError < RuntimeError; end

      # 2 megabytes
      # CHUNK_SIZE = 2 * 1024 * 1024
      CHUNK_SIZE = 6000

      BOUNDARY = "-----------RubyMultipartPost"

      # Check to make sure an upload ticket is still valid.
      create_api_method :check_ticket,
                        "vimeo.videos.upload.checkTicket",
                        :required => [:ticket_id]

      # Complete the upload process.
      create_api_method :complete,
                        "vimeo.videos.upload.complete",
                        :required => [:ticket_id, :filename]

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


      # Uploads data (IO streams or files) to Vimeo.
      def upload(uploadable)
        case uploadable
        when File
          upload_file(uploadable)
        when String
          upload_file(File.new(uploadable))
        else
          upload_io(uploadable)
        end
      end

      protected

      def upload_chunk(chunk_id, data, endpoint, filename)
        endpoint += "&chunk_id=#{chunk_id}"

        response = @oauth_consumer.request(:post, endpoint, get_access_token, {}, {}) do |req|
          req.set_content_type("multipart/form-data", { "boundary" => BOUNDARY })

          io = StringIO.new(data)
          io.instance_variable_set :"@original_filename", filename
          def io.original_filename; @original_filename; end
          def io.content_type; "application/octet-stream"; end

          parts = []
          parts << Parts::FilePart.new(BOUNDARY, "file_data", io)
          parts << Parts::EpiloguePart.new(BOUNDARY)

          ios                = parts.map{|p| p.to_io }
          req.content_length = parts.inject(0) {|sum,i| sum + i.length }
          req.body_stream    = CompositeReadIO.new(*ios)

          :continue
        end

        response.body
      end

      def upload_io(io, size, filename = 'io.data')
        raise "#{io.inspect} must respond to #read" unless io.respond_to?(:read)

        quota_response = get_quota
        user           = quota_response["user"]
        upload_space   = user["upload_space"]
        free           = upload_space["free"].to_i

        raise UploadError.new, "file size exceeds quota. required: #{size}, free: #{free}" if size > free

        ticket_response = get_ticket
        ticket          = ticket_response["ticket"]
        max_file_size   = ticket["max_file_size"].to_i
        ticket_id       = ticket["id"]
        endpoint        = ticket["endpoint"]

        raise UploadError.new, "file was too big: #{size}, maximum: #{max_file_size}" if size > max_file_size

        chunk_sizes = {}
        chunk_index = 0

        while (chunk = io.read(CHUNK_SIZE)) do

          chunk_id              = upload_chunk(chunk_index, chunk, endpoint, filename)
          chunk_sizes[chunk_id] = chunk.length
          chunk_index           += 1
        end

        validate_chunks_after_upload(ticket_id, chunk_sizes)

        complete(ticket_id, filename)
      end

      def upload_file(file)
        file_path = file.path

        size     = File.size(file_path)
        basename = File.basename(file_path)
        io       = File.open(file_path)
        io.binmode

        upload_io(io, size, basename).tap do
          io.close
        end
      end

      def validate_chunks_after_upload(ticket_id, chunk_sizes)
        verification    = verify_chunks(ticket_id)
        ticket          = verification["ticket"]
        chunk_list      = Array(ticket["chunks"]["chunk"])
        received_chunks = Hash[chunk_list.map { |chunk| [chunk["id"], chunk["size"].to_i] }]

        chunk_sizes.each do |id, size|
          vimeo_size = received_chunks[id]

          if vimeo_size != size
            raise UploadError.new, "Chunk (id: #{id}) was invalid - was: #{vimeo_size}, should be: #{size}."
          end
        end
      end
    end # Upload
  end # Advanced
end # Vimeo
