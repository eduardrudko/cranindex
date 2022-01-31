# frozen_string_literal: true

require 'fileutils'
require 'zlib'
require 'rubygems/package'

module Helpers
  class HeavyFileUtils

    BATCH_SIZE = 256
    ROOT_DIR = 'tmp'

    class << self
      # @return [File]
      def unpack_gz_by_batches(file, batch_size: BATCH_SIZE)
        return nil unless File.file?(file)

        unzipped_file_path = "#{ROOT_DIR}/#{File.basename(file, '.*')}"
        reader = Zlib::GzipReader.new(file)
        File.open unzipped_file_path, 'w' do |io|
          until reader.eof
            data = reader.readpartial(batch_size)
            io.write data
          end
        end
        File.new(unzipped_file_path)
      ensure
        FileUtils.remove(file)
      end

      def unpack_tar_gz(file)
        Gem::Package.new('').extract_tar_gz(file, ROOT_DIR)
      ensure
        FileUtils.remove_file(file)
      end
    end
  end
end