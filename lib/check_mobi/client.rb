require 'net/http'
require_relative '../check_mobi'

module CheckMobi

  class Client
    ALLOWED_METHODS = %i[get post].freeze

    attr_reader :endpoint, :request, :headers

    def initialize(options = {})
      @endpoint = URI(Configuration::DEFAULT_ENDPOINT +
                          options.fetch(:rel_path, '/'))

      @request = Net::HTTP.const_get(options.fetch(:http_method, :get)
                                         .to_s.capitalize).new(@endpoint)
      set_headers options[:headers]
      set_body options.fetch(:form_data, {})
    end

    def perform
      @request.initialize_http_header(@headers)
      res = Net::HTTP.start(@endpoint.hostname, @endpoint.port, use_ssl: true) do |http|
        http.request(@request)
      end
    end

    private

    def set_headers headers
      @headers = {}
      @headers['Content-Type'] = CheckMobi.content_type
      @headers['Accept'] = CheckMobi.accept_type
      @headers['Authorization'] = CheckMobi.api_key
    end

    def set_body(form_data)
      @request.form_data = form_data if
          @request.request_body_permitted?
    end
  end
end
