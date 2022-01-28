# frozen_string_literal: true

require 'rack'
require_relative '../helpers/heavy_file_loader'

namespace :index do
  namespace :cran do
    desc 'make an index of cran packages'
    task :perform do
      Helpers::HeavyFileLoader.new(
        "#{Rack::Directory.new('').root.to_s}/tmp/PACKAGES.gz",
        'http://cran.r-project.org/src/contrib/PACKAGES.gz'
      ).download_file
    end
  end
end