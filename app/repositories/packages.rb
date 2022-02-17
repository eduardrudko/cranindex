# frozen_string_literal: true

module Repositories
  module PackageRepository
    module_function

    def packages_based_on(placeholder, params)
      if params[:dependencies]
        packages = Package.where("#{placeholder} LIKE ?", "%#{params[placeholder]}%")
        packages || []
      end
    end

    def list_of_emails
      pattern = '%<%@%.%>%'
      emails = Package.select(:id, :authors, :maintainers).where('authors like ? or maintainers like ?', pattern, pattern)
      emails || []
    end
  end
end