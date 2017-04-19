require 'net/http'
require_relative '../check_mobi'
require_relative 'response'
require 'json'
require 'ostruct'
require 'forwardable'

module CheckMobi

  class Client

    extend Forwardable

    ALLOWED_METHODS = %i[get post].freeze

    attr_reader :endpoint, :request, :headers, :response
    def_delegator :response, :code, :status_code
    def_delegators :body, :code

    def initialize(options = {})
      @endpoint = URI(Configuration::DEFAULT_ENDPOINT +
                          options.fetch(:rel_path, '/'))

      @request = Net::HTTP.const_get(options.fetch(:http_method, :get)
                                         .to_s.capitalize).new(@endpoint)
      set_headers
      set_body options.fetch(:form_data, {})
    end

    def perform
      @request.initialize_http_header(@headers)

      @response = Net::HTTP.start(@endpoint.hostname, @endpoint.port, use_ssl: true) do |http|
        http.request(@request)
      end

      handle_response
    end

    def body
      OpenStruct.new(JSON.parse(response.body))
    end

    def is_successful
      code === /^"20\d"$/
    end

    private

    def set_headers
      @headers = {}
      @headers['Content-Type'] = CheckMobi.content_type
      @headers['Accept'] = CheckMobi.accept_type
      @headers['Authorization'] = CheckMobi.api_key
    end

    def set_body(form_data)
      @request.body = form_data.to_json if @request.request_body_permitted?
    end

    def handle_response
      CheckMobi::Response.new self
    end
  end
end
