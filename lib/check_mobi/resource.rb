require_relative 'client'
require_relative '../../lib/check_mobi/shared/class_with_attributes'

module CheckMobi
  class Resource
    include ClassWithAttributes

    def perform
      before_perform
      client.perform
    end

    def client
      Client.new(defaults)
    end

    private

    ALLOWED_METHODS = Client::ALLOWED_METHODS

    def after_initialize
      @platform ||= CheckMobi::Configuration::DEFAULT_PLATFORM if instance_variable_defined?(:@platform)
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
