require 'ostruct'
require 'json'
require 'forwardable'
require_relative '../../lib/check_mobi/errors/required_field_error'
require_relative '../../lib/check_mobi/client'

module CheckMobi
  class Response

    extend Forwardable

    def_delegators :@http_client, :status_code, :is_successful, :body, :response, :code
    def_delegator :response, :body, :response_body

    alias_method :reason, :body

    def initialize(http_client)
      raise RequiredFieldError, 'parameter should be a CheckMobi::Client, which is missing' unless http_client.kind_of? CheckMobi::Client
      @http_client = http_client
    end
  end
end
