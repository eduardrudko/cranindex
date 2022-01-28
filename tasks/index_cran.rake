# frozen_string_literal: true

require 'rack'
require_relative '../helpers/heavy_file_loader'

namespace :index do
  namespace :cran do
    desc 'make an index of cran packages'
    task :perform do
      loader = Helpers::HeavyFileLoader.new(
        "PACKAGES.gz",
        'http://cran.r-project.org/src/contrib/PACKAGES.gz'
      )
      loader.unzip(loader.download)
    end
  end
end