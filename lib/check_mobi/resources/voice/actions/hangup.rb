require_relative '../../../resource'
require_relative '../events'

module CheckMobi
  module Resources
    module Voice
      module Actions

        class Hangup < Events
          attributes :reason
        end

      end
    end
  end
end

