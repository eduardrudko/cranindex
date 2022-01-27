# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'fileutils'

module Helpers
  class HeavyFileDownloader

    WHITE_LISTED_FILES = ['PACKAGES.gz'].freeze

    def initialize(file_path, url)
      @uri = URI(URI.encode(url))
      @file_path = file_path
    end

    def download_file
      return nil unless WHITE_LISTED_FILES.include?(@uri.path.split('/').last)

      fetch_and_save_by_fragments
    end

    private

    def fetch_and_save_by_fragments
      Net::HTTP.start(@uri.host, @uri.port) do |http|
        request = Net::HTTP::Get.new @uri.path
        FileUtils.mkdir_p 'tmp/'
        http.request request do |response|
          File.open @file_path, 'w' do |io|
            response.read_body do |chunk|
              io.write chunk
            end
          end
        end
      end
    end
  end
end