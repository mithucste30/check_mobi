require_relative '../../../resource'
require_relative '../events'

module CheckMobi
  module Resources
    module Voice
      module Actions

        class Wait < Events
          attributes :length

          private

          def after_initialize
            @length ||= 1
            super
          end
        end
      end
    end
  end
end
