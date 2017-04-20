require_relative '../../resource'

module CheckMobi
  module Resources
    module PhoneValidation
      class VerifyPin < Resource

        attributes :id, :pin, :use_server_hangup

        private

        def defaults
          super.merge!({
              rel_path: '/validation/verify',
              http_method: ALLOWED_METHODS[1],
              form_data: {
                  id: @id,
                  pin: @pin,
                  use_server_hangup: @use_server_hangup
              }
           })
        end
      end
    end
  end
end