module CheckMobi
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent, :method].freeze
    VALID_OPTIONS_KEYS = [:api_key, :format].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT = 'https://api.checkmobi.com/v1'

    DEFAULT_METHOD = :post
    DEFAULT_USER_AGENT = "CheckMobi API Ruby Gem".freeze

    DEFAULT_API_KEY = nil
    DEFAULT_FORMAT = :json

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def reset
      self.endpoint = DEFAULT_ENDPOINT
      self.method = DEFAULT_METHOD
      self.user_agent = DEFAULT_USER_AGENT
      self.api_key = DEFAULT_API_KEY
      self.format = DEFAULT_FORMAT
    end

    def configure
      yield self
    end

    def options
      Hash[*VALID_CONFIG_KEYS.map{|key| [key, send(key)]}.flatten]
    end

  end #configuration
end

