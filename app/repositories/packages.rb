# frozen_string_literal: true

module Repositories
  module PackageRepository
    module_function

    def get_packages_based_on(placeholder, params)
      if params[:dependencies]
        packages = Package.where("#{placeholder} LIKE ?", "%#{params[placeholder]}%")
        packages || []
      end
    end
  end
end