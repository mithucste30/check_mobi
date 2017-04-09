require_relative '../../../resource'
require_relative '../events'

module CheckMobi
  module Resources
    module Voice
      module Actions

        class Speak < Events
          attr_accessor :text, :loop, :voice, :language

          def after_initialize
            @loop ||= 1
            @voice ||= 'WOMAN'
            @language ||= 'en-US'
          end
        end
      end
    end
  end
end
