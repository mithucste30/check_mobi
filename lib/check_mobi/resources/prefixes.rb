require_relative '../resource'

module CheckMobi
  module Resources
    class Prefixes < Resource

      private

      def defaults
        {
            rel_path: '/prefixes',
            http_method: ALLOWED_METHODS[0]
        }
      end
    end
  end
end