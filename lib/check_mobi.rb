require_relative 'check_mobi/configuration'
require_relative 'check_mobi/core_ext/string'
require_relative 'check_mobi/core_ext/hash'

$:.unshift File.expand_path(File.dirname(__FILE__))

module CheckMobi

  autoload :Client, 'check_mobi/client'
  autoload :Response, 'check_mobi/response'

  module Resources
    autoload :CountryList, 'check_mobi/resources/country_list'
    autoload :CheckNumber, 'check_mobi/resources/check_number'
    autoload :Prefixes, 'check_mobi/resources/prefixes'
    autoload :MyAccount, 'check_mobi/resources/my_account'

    module SMS
      autoload :Send, 'check_mobi/resources/sms/send'
      autoload :Details, 'check_mobi/resources/sms/details'
    end

    module PhoneValidation
      autoload :RequestValidation, 'check_mobi/resources/phone_validation/request_validation'
      autoload :ValidationStatus, 'check_mobi/resources/phone_validation/validation_status'
      autoload :VerifyPin, 'check_mobi/resources/phone_validation/verify_pin'
    end

    module Voice
      autoload :Call, 'check_mobi/resources/voice/call'
      autoload :CallDetails, 'check_mobi/resources/voice/call_details'
      autoload :HangupCall, 'check_mobi/resources/voice/hangup_call'

      module Actions
        autoload :Hangup, 'check_mobi/resources/voice/actions/hangup'
        autoload :Play, 'check_mobi/resources/voice/actions/play'
        autoload :SendDTMF, 'check_mobi/resources/voice/actions/send_dtmf'
        autoload :Speak, 'check_mobi/resources/voice/actions/speak'
        autoload :Wait, 'check_mobi/resources/voice/actions/wait'
      end
    end
  end

  extend Configuration
end
