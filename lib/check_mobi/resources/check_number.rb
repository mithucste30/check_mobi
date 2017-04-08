require_relative '../resource'

module CheckMobi
  module Resources
    class CheckNumber < Resource

      def initialize(phone_number: '')
        @phone_number = phone_number
        super
      end

      private

      def defaults
        super.merge!({
            rel_path: '/checknumber',
            http_method: ALLOWED_METHODS[1],
            form_data: {number: @phone_number}
        })
      end
    end
  end
end

