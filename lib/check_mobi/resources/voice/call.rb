require_relative '../../resource'
require_relative '../../shared/class_with_attributes'

module CheckMobi
  module Resources
    module Voice

      class Call < Resource
        include ClassWithAttributes

        attr_accessor :from, :to, :events, :notification_callback, :platform

        def initialize(params)
          params.each {|k,v| public_send("#{k}=",v)}
          @events ||= []
          super
        end

        private

        def defaults
          super.merge!({
              rel_path: '/call',
              http_method: ALLOWED_METHODS[1],
              form_data: form_data
          })
        end

        def before_perform
          prepare_events
          @client = Client.new(defaults)
        end

        def prepare_events
          uniq_events = @events.uniq { |event| event.action }

          uniq_events.each do |event|
            hash = {}

            event.attributes.each do |attr|
              hash[attr] = event.send(attr)
            end

            @events << hash
          end
        end

        def form_data
          hash = {}
          attributes.each do |attr|
            hash[attr] = send(attr)
          end
          return form_data
        end
      end
    end
  end
end