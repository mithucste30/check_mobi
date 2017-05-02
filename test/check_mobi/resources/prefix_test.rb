require 'helper'

describe CheckMobi::Resources::Prefixes do
  before do
    CheckMobi.api_key = ENV['API_KEY']
    @endpoint = 'https://api.checkmobi.com/v1/prefixes'
    stub_get_request(@endpoint)
  end

  it 'should fetch prefixes' do
    resource = CheckMobi::Resources::Prefixes.new
    resource.perform
    assert_requested(:get, @endpoint, headers: headers_with_authorization, times: 1)
  end
end