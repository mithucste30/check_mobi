require_relative '../../../resource'
require_relative '../events'

module CheckMobi
  module Resources
    module Voice
      module Actions
        class Play < Events
          attr_accessor :url, :loop

          private

          def after_initialize
            @loop ||= 1
          end
        end
      end
    end
  end
end
