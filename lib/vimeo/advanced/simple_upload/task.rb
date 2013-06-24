module Vimeo
  module Advanced
    module SimpleUpload
      class Task
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

        # Uploads the file to Vimeo and returns the +video_id+ on success.
        def execute
          check_quota
          authorize
          upload
          raise UploadError.new, "Validation of chunks failed." unless valid?
          complete

          return video_id
        end

        def stream(&block)
          raise ArgumentError, "A block is required to stream uploads" unless block_given?

          check_quota
          authorize

          yield self

          raise UploadError.new, "Validation of chunks failed." unless valid?
          complete
          video_id
        end

        def <<(data)
          chunk = Chunk.new(self, data)
          chunk.upload
          chunks << chunk
        end

        protected

        # Checks whether the file can be uploaded.
        def check_quota
          quota = vimeo.get_quota
          free  = quota["user"]["upload_space"]["free"].to_i

          raise UploadError.new, "file size exceeds quota. required: #{size}, free: #{free}" if size > free
        end

        # Gets a +ticket_id+ for the upload.
        def authorize
          ticket = vimeo.get_ticket

          @id             = ticket["ticket"]["id"]
          @endpoint       = ticket["ticket"]["endpoint"]
          max_file_size   = ticket["ticket"]["max_file_size"].to_i

          raise UploadError.new, "file was too big: #{size}, maximum: #{max_file_size}" if size > max_file_size
        end

        # Performs the upload.
        def upload
          while (chunk_data = io.read(CHUNK_SIZE)) do
            chunk = Chunk.new(self, chunk_data)
            chunk.upload
            chunks << chunk
          end
        end

        # Tells vimeo that the upload is complete.
        def complete
          @video_id = vimeo.complete(id, filename)
        end

        # Compares Vimeo's chunk list with own chunk list. Returns +true+ if identical.
        def valid?
          received, sent = received_chunk_sizes, sent_chunk_sizes
          sent.all? { |id, size| received[id] == size }
        end

        # Returns a hash of the sent chunks and their respective sizes.
        def sent_chunk_sizes
          Hash[chunks.map { |chunk| [chunk.index.to_s, chunk.size] }]
        end

        # Returns a of Vimeo's received chunks and their respective sizes.
        def received_chunk_sizes
          verification    = vimeo.verify_chunks(id)
          chunk_list      = verification["ticket"]["chunks"]["chunk"]
          chunk_list      = [chunk_list] unless chunk_list.is_a?(Array)
          Hash[chunk_list.map { |chunk| [chunk["id"], chunk["size"].to_i] }]
        end
      end
    end
  end
end
