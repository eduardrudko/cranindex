# frozen_string_literal: true

module Repositories
  module PackageRepository

    EMAIL_REGEX = /[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+/.freeze

    module_function

    def packages_based_on(placeholder, params)
      if params[:dependencies]
        packages = Package.where("#{placeholder} LIKE ?", "%#{params[placeholder]}%")
        packages || []
      end
    end

    def uniq_emails
      emails.uniq
    end

    def contributor
      count = {}
      emails.each do |c|
        if count[c].nil?
          count[c] = 1
        else
          count[c] += 1
        end
      end
      count = {}
      count.max { |a, b| a[1] <=> b[1] }[0] unless count.empty?
    end

    def emails
      pattern = '%<%@%.%>%'
      emails = []
      Package
        .select(:id, :authors, :maintainers)
        .where('authors like ? OR maintainers LIKE ?', pattern, pattern)
        .find_each do |package|
          emails.concat(package.authors.scan(EMAIL_REGEX))
          emails.concat(package.maintainers.scan(EMAIL_REGEX))
      end
      emails.sort.each(&:downcase!)
    end
  end
end