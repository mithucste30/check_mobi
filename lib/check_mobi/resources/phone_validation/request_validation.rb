require_relative '../../resource'

module CheckMobi
  module Resources
    module PhoneValidation
      class RequestValidation < Resource

        def initialize(number: '', type: '', language: '', notification_callback: '', platform: '')
          @number = number
          @type = type
          @langauge = language
          @notification_callback = notification_callback
          @platform = platform
          super
        end

        private

        def defaults
          super.merge!({
              rel_path: '/validation/request',
              http_method: ALLOWED_METHODS[1],
              form_data: {
                  number: @number,
                  type: @type,
                  langauge: @langauge,
                  notification_callback: @notification_callback,
                  platform: @platform
              }
          })
        end
      end
    end
  end
end