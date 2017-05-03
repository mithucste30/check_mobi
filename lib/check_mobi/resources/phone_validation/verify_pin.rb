require_relative '../../resource'

module CheckMobi
  module Resources
    module PhoneValidation
      class VerifyPin < Resource

        attributes :id, :pin
        attribute :use_server_hangup, default: false

        private

        def defaults
          super.merge!({
              rel_path: '/validation/verify',
              http_method: ALLOWED_METHODS[1],
              form_data: to_hash
           })
        end
      end
    end
  end
end