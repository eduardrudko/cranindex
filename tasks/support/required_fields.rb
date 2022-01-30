# frozen_string_literal: true

module Tasks
  module Support
    module PackageFields

      REQUIRED_FIELDS = %w[Package Version Depends Date/Publication Title Author Maintainer License].freeze

      def name
        REQUIRED_FIELDS[0]
      end

      def version
        REQUIRED_FIELDS[1]
      end

      def depends
        REQUIRED_FIELDS[2]
      end

      def date_of_publication
        REQUIRED_FIELDS[3]
      end

      def title
        REQUIRED_FIELDS[4]
      end

      def author
        REQUIRED_FIELDS[5]
      end

      def maintainer
        REQUIRED_FIELDS[6]
      end

      def license
        REQUIRED_FIELDS[7]
      end

      def url
        'url'
      end
    end
  end
end