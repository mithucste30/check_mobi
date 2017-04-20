require_relative '../../resource'

module CheckMobi
  module Resources
    module PhoneValidation
      class ValidationStatus < Resource

        attributes :id

        private

        def defaults
          super.merge!({
              rel_path: "/validation/status/#{@id}",
              http_method: ALLOWED_METHODS[0]
          })
        end
      end
    end
  end
end