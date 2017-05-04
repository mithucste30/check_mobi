require_relative '../../resource'
require_relative '../../shared/class_with_attributes'

module CheckMobi
  module Resources
    module Voice

      class HangupCall < Resource

        attributes :req_id

        private

        def defaults
          super.merge!({
                           rel_path: "/call/#{@req_id}",
                           http_method: ALLOWED_METHODS[2]
                       })
        end

      end
    end
  end
end