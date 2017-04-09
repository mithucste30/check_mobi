require_relative '../../resource'


module CheckMobi
  module Resources
    module Voice

      class Call < Resource

        attr_accessor :from, :to, :events, :notification_callback, :platform

        def initialize(params)
          params.each {|k,v| public_send("#{k}=",v)}
          @events ||= []
          super
        end

        private

        def defaults

        end

      end

    end
  end
end