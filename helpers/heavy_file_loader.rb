# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'fileutils'
require 'zlib'

module Helpers
  class HeavyFileLoader

    WHITE_LISTED_FILES = ['PACKAGES.gz'].freeze
    BATCH_SIZE = 256
    ROOT_DIR = 'tmp'

    def initialize(file_name, url)
      @uri = URI(URI.encode(url))
      @file_path = "#{ROOT_DIR}/#{file_name}"
    end

    def download
      return nil unless WHITE_LISTED_FILES.include?(@uri.path.split('/').last)

      fetch_and_save_by_fragments
    end

    def ungzip(file)
      return nil unless File.file?(file)

      unzipped_file_path = "#{ROOT_DIR}/#{File.basename(@file_path, '.*')}"
      rgz = Zlib::GzipReader.new(file)
      File.open unzipped_file_path, 'w' do |io|
        until rgz.eof
          data = rgz.readpartial(BATCH_SIZE)
          io.write data
        end
      end
      File.new(unzipped_file_path)
    end

    private

    def fetch_and_save_by_fragments
      Net::HTTP.start(@uri.host, @uri.port) do |http|
        request = Net::HTTP::Get.new @uri.path
        FileUtils.mkdir_p ROOT_DIR.to_s
        begin
          http.request request do |response|
            File.open @file_path, 'w' do |io|
              response.read_body do |chunk|
                io.write chunk.force_encoding('UTF-8')
              end
            end
          end
        rescue StandardError => e
          FileUtils.rm_rf ROOT_DIR.to_s
          raise StandardError e
        end
        File.new(@file_path)
      end
    end
  end
end