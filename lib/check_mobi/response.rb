require 'ostruct'
require 'json'

module CheckMobi
  class Response

    attr_reader :code, :is_successful, :reason, :body

    def initialize(http_client)
      response = http_client.response
      body = parse_body(response.body)

      @code = response.code.to_i
      @is_successful = @code === /^20\d$/

      if @is_successful
        @body = body
      else
        @reason = body
      end
    end

    private

    def parse_body(body)
      OpenStruct.new(JSON.parse(body))
    end
  end
end