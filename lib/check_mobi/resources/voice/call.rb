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
              form_data: form_data
          })
        end

        # def before_perform
        #   uniq_events = @events.uniq { |event| event.action }
        #
        #   uniq_events.each do |event|
        #     hash = {}
        #
        #     event.attributes.each do |attr|
        #       hash[attr] = event.send(attr)
        #     end
        #
        #     @events << hash
        #   end
        # end

        def form_data
          hash = {}

          self.class.instance_variable_get(@attributes).each do |attr|
            hash[attr] = send(attr)
          end

          return form_data
        end

      end
    end
  end
end