require_relative '../../resource'

module CheckMobi
  module Resources
    module PhoneValidation
      class RequestValidation < Resource

        attributes :number, :type, :language, :notification_callback, :platform

        private

        def defaults
          super.merge!({
              rel_path: '/validation/request',
              http_method: ALLOWED_METHODS[1],
              form_data: to_hash
          })
        end
      end
    end
  end
end
