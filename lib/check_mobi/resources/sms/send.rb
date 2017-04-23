require_relative '../../resource'


module CheckMobi
  module Resources
    module SMS
      class Send < Resource

        attributes :to, :text, :notification_callback, :platform

        private

        def defaults
          super.merge!({
              rel_path: '/sms/send',
              http_method: ALLOWED_METHODS[1],
              form_data: to_hash
          })
        end
      end
    end
  end
end
