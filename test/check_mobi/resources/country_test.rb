require 'helper'

describe CheckMobi::Resources::CountryList do
  before do
    @endpoint = 'https://api.checkmobi.com/v1/countries'
    stub_get_request(@endpoint)
  end

  it "should request country list" do
    @resource = CheckMobi::Resources::CountryList.new
    @resource.perform
    assert_requested(:get, @endpoint, headers: headers_without_authorization, times: 1)
  end
end
