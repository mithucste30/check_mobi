require 'helper'
require 'check_mobi/resources/country_list'

describe CheckMobi::Resources::CountryList do

  it "should fetch country list" do
    @resource = CheckMobi::Resources::CountryList.new
    request = @resource.perform
    request.response.code.must_equal "200"
  end
end
