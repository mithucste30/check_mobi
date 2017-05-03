require 'helper'

describe CheckMobi::Resources::Prefixes do
  before do
    CheckMobi.api_key = ENV['API_KEY']
    @endpoint = 'https://api.checkmobi.com/v1/prefixes'
  end

  it 'should fetch prefixes' do
    stub_get_request(@endpoint)
    resource = CheckMobi::Resources::Prefixes.new
    resource.perform
    assert_requested(:get, @endpoint, headers: headers_with_authorization, times: 1)
  end
end