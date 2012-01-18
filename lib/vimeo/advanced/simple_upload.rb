module Vimeo
  module Advanced
    module SimpleUpload
      class UploadError < RuntimeError; end

      autoload :Task,         'vimeo/advanced/simple_upload/task'
      autoload :Chunk,        'vimeo/advanced/simple_upload/chunk'

      # Uploads data (IO streams or files) to Vimeo.
      def upload(uploadable)
        case uploadable
        when File, Tempfile
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
        task = Task.new(self, @oauth_consumer, io, size, filename)
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
    end
  end
end