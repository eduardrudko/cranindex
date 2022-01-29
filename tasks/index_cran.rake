# frozen_string_literal: true

require 'debian_control_parser'
require_relative '../helpers/heavy_file_loader'

REQUIRED_FIELDS = %w[Package Version Depends Date/Publication Title Author Maintainer License].freeze
PACKAGES = 'PACKAGES.gz'
CRAN_DOMAIN = 'http://cran.r-project.org/'
CRAN_ROUTE = 'src/contrib/'
URL = "#{CRAN_DOMAIN}#{CRAN_ROUTE}#{PACKAGES}"


namespace :index do
  namespace :cran do
    desc 'make an index of cran packages'
    task :perform do
      loader = Helpers::HeavyFileLoader.new(PACKAGES, URL)
      compressed_packages = loader.download
      decompressed_packages = loader.ungzip(compressed_packages)
      format_urls_from_packages(decompressed_packages)
    end
  end
end

def get_package_version_mapping(decompressed_packages)
  parser = DebianControlParser.new(decompressed_packages)
  package_version_mapping = []
  parser.paragraphs do |paragraph|
    name = ''
    version = ''
    paragraph.fields do |key, value|
      name = value if package_name?(key)
      version = value if package_version?(key)
    end
    package_version_mapping << { package_key => name, version_key => version } if !name.empty? && !version.empty?
  end
  package_version_mapping
end

def format_urls_from_packages(decompressed_packages)
  mapping = get_package_version_mapping(decompressed_packages)
end

def package_name?(key)
  key == package_key
end

def package_key
  REQUIRED_FIELDS[0]
end

def package_version?(key)
  key == version_key
end

def version_key
  REQUIRED_FIELDS[1]
end