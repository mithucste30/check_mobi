require_relative 'check_mobi/configuration'

$:.unshift File.expand_path(File.dirname(__FILE__))

module CheckMobi
  module Resources
    autoload :CountryList, 'check_mobi/resources/country_list'

  end

  extend Configuration
end
