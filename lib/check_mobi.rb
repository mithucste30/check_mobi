require "check_mobi/version"
require "check_mobi/configuration"
require "check_mobi/client"
require

module CheckMobi
  module Service
    autoload :CountryList, "check_mobi/services/country_list"    
  end
  extend Configuration
end
