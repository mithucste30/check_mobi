require_relative '../../resource'


module CheckMobi
  module Resources
    module SMS
      class Send < Resource

        def initialize(to: '', text: '', notification_callback: nil, platform: '')
          @form_data = {
              to: to,
              text: text,
              notification_callback: notification_callback,
              platform: platform
          }
          super
        end

        private

        def defaults
          super.merge!({
              rel_path: '/sms/send',
              http_method: ALLOWED_METHODS[1],
              form_data: @form_data
          })
        end

      end
    end
  end
end