# frozen_string_literal: true

require 'net/http'
require 'uri'

module Helpers
  class HeavyFileDownloader

    WHITE_LISTED_FORMATS = %w[gz tar].freeze
    ROOT_DIR = 'tmp'

    class << self

      # @return [File]
      def download(url)
        uri = URI(URI.encode(url))
        file_path = "#{ROOT_DIR}/#{file_name_from_uri(uri)}"

        return nil unless WHITE_LISTED_FORMATS.include?(uri.path.split('.').last)

        fetch_and_save_by_fragments(uri, file_path)
      end

      private

      def fetch_and_save_by_fragments(uri, file_path)
        Net::HTTP.start(uri.host, uri.port) do |http|
          request = Net::HTTP::Get.new uri.path
          FileUtils.mkdir_p ROOT_DIR.to_s
          begin
            http.request request do |response|
              File.open file_path, 'w' do |io|
                response.read_body do |chunk|
                  io.write chunk.force_encoding('UTF-8')
                end
              end
            end
          rescue StandardError => e
            FileUtils.rm_rf ROOT_DIR.to_s
            raise StandardError e
          end
          File.new(file_path)
        end
      end

      def file_name_from_uri(uri)
        return '' if uri.nil?

        uri.path.split('/').last
      end
    end
  end
end