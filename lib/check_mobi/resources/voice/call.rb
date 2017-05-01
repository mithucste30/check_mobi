require_relative '../../resource'
require_relative '../../shared/class_with_attributes'

module CheckMobi
  module Resources
    module Voice

      class Call < Resource

        attributes :from, :to, :notification_callback, :platform
        attribute :events, default: []

        private

        def defaults
          super.merge!({
              rel_path: '/call',
              http_method: ALLOWED_METHODS[1],
              form_data: to_hash
          })
        end

      end
    end
  end
end