# frozen_string_literal: true

require 'celluloid/current'
require 'dcf'
require_relative 'required_fields'

module Tasks
  module Support
    class PackageWorker
      include Celluloid
      include Tasks::Support::PackageFields

      def process_package(package_mapping, path)
        LOGGER.info "Processing ... #{package_mapping}"
        Helpers::HeavyFileUtils.unpack_tar_gz(Helpers::HeavyFileDownloader.download(package_mapping[url]))
        desc = Dcf.parse(File.read("#{path}/#{DESC_FILE_NAME}").encode(Encoding::UTF_8.name, invalid: :replace,
                                                                                             replace: '?'))
        upsert_package_data(desc, package_mapping[url])
        LOGGER.info "Finished processing #{package_mapping}"
      ensure
        FileUtils.remove_dir(path.to_s) if File.exist?(path.to_s)
      end

      def upsert_package_data(desc, url)
        desc.each do |p|
          Package.find_or_create_by(name: p[name]).update(
            version: p[version],
            r_version_needed: p[depends]&.split(',')&.first,
            dependencies: p[depends]&.split(',')&.drop(1)&.join&.strip,
            date_of_publication: p[date_of_publication],
            title: p[title],
            maintainers: p[maintainer],
            license: p[license],
            url: url
          )
        end
      end
    end
  end
end