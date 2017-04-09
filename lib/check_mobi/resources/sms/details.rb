require_relative '../../resource'


module CheckMobi
  module Resources
    module SMS
      class Details < Resource

        def initialize(id: '')
          @id = id
          super
        end

        private

        def defaults
          super.merge!({
               rel_path: "/sms/#{@id}",
               http_method: ALLOWED_METHODS[0]
           })
        end

      end
    end
  end
end