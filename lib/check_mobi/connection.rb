require 'faraday'

module CheckMobi
  class Connection

    def initialize
      @connection = Faraday.new(CheckMobi::Configuration::DEFAULT_ENDPOINT) do |faraday|
        yield faraday
      end
    end

  end
end
