require_relative '../../../resource'
require_relative '../events'

module CheckMobi
  module Resources
    module Voice
      module Actions

        class SendDTMF < Events
          attributes :digits, :async

          private

          def after_initialize
            @async = true if @async.nil?
            super
          end
        end
      end
    end
  end
end
