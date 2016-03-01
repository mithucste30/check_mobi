module CheckMobi

  class Client

    attr_accessor *Configuration::VALID_CONFIG_KEYS
    attr_accessor << :rel_path

    def initialize(options={})
      merged_options = CheckMobi.options.merge(options)

      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}", merged_options[key])
      end
    end

    def fetch_countries

    end

    def get_prefixes

    end

    def check_number(number)

    end

    def verify_pin(id, pin, use_server_hangup = false)

    end



    def send_sms(to_number, text)

    end
  end
end
