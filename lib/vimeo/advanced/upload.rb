require 'json'

module Vimeo
  module Advanced

    class Upload < Vimeo::Advanced::Base
      class UploadError < RuntimeError; end

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

      class UploadTask
        class UploadChunk
          MULTIPART_BOUNDARY = "-----------RubyMultipartPost"

          attr_reader :id, :index
          attr_reader :task, :vimeo
          attr_reader :data, :size

          def initialize(task, data)
            @task = task
            @vimeo = task.vimeo
            @data = data
            @size = data.size
            @index = task.chunks.count
          end

          def upload
            endpoint = "#{task.endpoint}&chunk_id=#{index}"

            response = task.oauth_consumer.request(:post, endpoint, vimeo.get_access_token, {}, {}) do |req|
              req.set_content_type("multipart/form-data", { "boundary" => MULTIPART_BOUNDARY })

              io = StringIO.new(data)
              io.instance_variable_set :"@original_filename", task.filename
              def io.original_filename; @original_filename; end
              def io.content_type; "application/octet-stream"; end

              parts = []
              parts << Parts::FilePart.new(MULTIPART_BOUNDARY, "file_data", io)
              parts << Parts::EpiloguePart.new(MULTIPART_BOUNDARY)

              ios                = parts.map{|p| p.to_io }
              req.content_length = parts.inject(0) {|sum,i| sum + i.length }
              req.body_stream    = CompositeReadIO.new(*ios)

              :continue
            end

            @data = nil
            @id = response.body
          end
        end

        CHUNK_SIZE = 2 * 1024 * 1024 # 2 megabytes

        attr_reader :vimeo, :oauth_consumer
        attr_reader :io, :size, :filename
        attr_reader :chunks, :endpoint
        attr_reader :id, :video_id

        def initialize(vimeo, oauth_consumer, io, size, filename)
          @vimeo, @oauth_consumer = vimeo, oauth_consumer
          @io, @size, @filename = io, size, filename
          @chunks = []
        end

        def execute
          check_quota
          authorize
          upload
          raise UploadError.new, "Validation of chunks failed." unless valid?
          complete

          return video_id
        end

        protected

        def check_quota
          quota = vimeo.get_quota
          free  = quota["user"]["upload_space"]["free"].to_i

          raise UploadError.new, "file size exceeds quota. required: #{size}, free: #{free}" if size > free
        end

        def authorize
          ticket = vimeo.get_ticket

          @id             = ticket["ticket"]["id"]
          @endpoint       = ticket["ticket"]["endpoint"]
          max_file_size   = ticket["ticket"]["max_file_size"].to_i

          raise UploadError.new, "file was too big: #{size}, maximum: #{max_file_size}" if size > max_file_size
        end

        def upload
          while (chunk_data = io.read(CHUNK_SIZE)) do
            chunk = UploadChunk.new(self, chunk_data)
            chunk.upload
            chunks << chunk
          end
        end

        def complete
          @video_id = vimeo.complete(id, filename)
        end

        def valid?
          received, sent = received_chunk_sizes, sent_chunk_sizes
          sent.all? { |id, size| received[id] == size }
        end

        def sent_chunk_sizes
          Hash[chunks.map { |chunk| [chunk.id, chunk.size] }]
        end

        def received_chunk_sizes
          verification    = vimeo.verify_chunks(id)
          chunk_list      = verification["ticket"]["chunks"]["chunk"]
          chunk_list      = [chunk_list] unless chunk_list.is_a?(Array)
          Hash[chunk_list.map { |chunk| [chunk["id"], chunk["size"].to_i] }]
        end
      end

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

      # Uploads an IO to Vimeo.
      def upload_io(io, size, filename = 'io.data')
        raise "#{io.inspect} must respond to #read" unless io.respond_to?(:read)
        task = UploadTask.new(self, @oauth_consumer, io, size, filename)
        task.execute
        task.video_id
      end

      # Helper for uploading files to Vimeo.
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
    end # Upload
  end # Advanced
end # Vimeo
