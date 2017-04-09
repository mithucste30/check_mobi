require_relative '../../../resource'
require_relative '../events'

module CheckMobi
  module Resources
    module Voice
      module Actions

        class SendDTMF < Events
          attr_accessor :digits, :async

          private

          def after_initialize
            @async = true if @async.nil?
          end
        end
      end
    end
  end
end
