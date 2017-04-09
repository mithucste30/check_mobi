require_relative '../../../resource'
require_relative '../events'

module CheckMobi
  module Resources
    module Voice
      module Actions

        class Hangup < Events
          attr_accessor :reason
        end

      end
    end
  end
end

