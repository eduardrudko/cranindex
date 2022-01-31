# frozen_string_literal: true

require 'dcf'
require 'deb_control'
require_relative '../helpers/heavy_file_utils'
require_relative '../helpers/heavy_file_downloader'
require_relative '../models/package'
require_relative 'support/required_fields'
require_relative 'support/package_worker'

PACKAGES_FILE_NAME = 'PACKAGES.gz'
DESC_FILE_NAME = 'DESCRIPTION'
CRAN_DOMAIN = 'http://cran.r-project.org/'
CRAN_ROUTE = 'src/contrib/'
URL = "#{CRAN_DOMAIN}#{CRAN_ROUTE}"

namespace :index do
  namespace :cran do
    desc 'make an index of cran packages'
    task perform: :environment do
      include Tasks::Support::PackageFields

      compressed_packages = Helpers::HeavyFileDownloader.download("#{URL}#{PACKAGES_FILE_NAME}")
      decompressed_packages = Helpers::HeavyFileUtils.unpack_gz_by_batches(compressed_packages)

      mapping = mapping_from_packages(decompressed_packages)

      worker_pool = Tasks::Support::PackageWorker.pool(size: WORKERS_POOL_SIZE)

      mapping.each do |m|
        worker_pool.async.process_package(m, "#{Helpers::HeavyFileUtils::ROOT_DIR}/#{m[name]}")
        sleep WORKERS_POOL_INTERVAL until worker_pool.idle_size.positive?
      end
      shutdown_gracefully(worker_pool)
    end
  end
end

def shutdown_gracefully(pool)
  sleep WORKERS_POOL_INTERVAL until pool.idle_size == WORKERS_POOL_SIZE
  LOGGER.info 'Shut down gracefully ... hooray!'
end

def mapping_from_packages(decompressed_packages)
  DebControl::ControlFileBase.read(decompressed_packages).paragraphs.map do |p|
    {
      name => p[name],
      version => p[version],
      url => "#{URL}#{p[name]}_#{p[version]}.tar.gz"
    }
  end
end