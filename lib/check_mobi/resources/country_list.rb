require_relative '../resource'


module CheckMobi
  module Resources
    class CountryList < Resource

      private

      def defaults
        super.merge({
            rel_path: '/countries',
            http_method: ALLOWED_METHODS[0]
        })
      end
    end
  end
end

