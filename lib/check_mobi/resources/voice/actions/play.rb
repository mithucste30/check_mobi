require_relative '../../../resource'
require_relative '../events'

module CheckMobi
  module Resources
    module Voice
      module Actions
        class Play < Events
          attributes :url, :loop

          private

          def after_initialize
            @loop ||= 1
            super
          end
        end
      end
    end
  end
end
