module Vimeo
  module Advanced
    module SimpleUpload
      class Chunk
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

        # Performs the upload via Multipart.
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

          # free memory (for big file uploads)
          @data = nil

          @id = response.body
        end
      end
    end
  end
end