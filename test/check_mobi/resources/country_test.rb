require 'helper'

describe CheckMobi::Resources::CountryList do

  it "should fetch country list" do
    @resource = CheckMobi::Resources::CountryList.new
    response = @resource.perform
    response.status_code.must_equal '200'
  end
end
