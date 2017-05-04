require_relative '../../resource'
require_relative '../../shared/class_with_attributes'

module CheckMobi
  module Resources
    module Voice

      class CallDetails < Resource

        attributes :id

        private

        def defaults
          super.merge!({
                           rel_path: "/call/#{@id}",
                           http_method: ALLOWED_METHODS[0]
                       })
        end

      end
    end
  end
end