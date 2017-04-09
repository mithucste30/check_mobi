require_relative 'client'

module CheckMobi
  class Resource
    attr_reader :client

    def perform
      before_perform
      @client.perform
    end

    private

    ALLOWED_METHODS = Client::ALLOWED_METHODS

    def initialize(*args)
      @client = Client.new(defaults)
    end

    def defaults
      {
          rel_path: nil,
          http_method: nil,
          form_data: nil
      }
    end

    def before_perform  # overridden by subclasses

    end
  end
end