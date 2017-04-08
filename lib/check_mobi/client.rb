require 'net/http'
require_relative '../check_mobi'

module CheckMobi

  class Client
    ALLOWED_METHODS = [:get, :post].freeze

    def initialize(options = {})
      @endpoint = URI(Configuration::DEFAULT_ENDPOINT + options.fetch(:rel_path, '/'))
      @request = Net::HTTP.const_get(options.fetch(:http_method, :get).to_s.capitalize).new(@endpoint)
      set_headers
      set_body options
    end

    def perform
      res = Net::HTTP.start(@endpoint.hostname, @endpoint.port, :use_ssl => true) {|http|
        http.request(@request)
      }
      return res
    end

    private

    def set_headers
      @request['Content-Type'] = 'application/json'
      @request['Accept'] = 'application/json'
      @request['Authorization'] = CheckMobi.api_key
    end

    def set_body(options)
      @request.form_data = options[:form_data] if @request.request_body_permitted?
    end
  end
end
