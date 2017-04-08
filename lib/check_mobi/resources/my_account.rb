require_relative '../resource'

module CheckMobi
  module Resources
    class MyAccount < Resource

      private

      def defaults
        super.merge!({
            rel_path: '/my-account',
            http_method: ALLOWED_METHODS[0]
        })
      end
    end
  end
end
