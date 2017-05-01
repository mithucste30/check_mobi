require 'helper'

describe CheckMobi::Resources::MyAccount do
  before do
    CheckMobi.api_key = ENV['API_KEY']
    @endpoint = 'https://api.checkmobi.com/v1/my-account'
    stub_get_request(@endpoint)
  end

  it 'should fetch account info with valid api_key' do
    resource = CheckMobi::Resources::MyAccount.new
    resource.perform
    assert_requested(:get, @endpoint, headers: headers_with_authorization, times: 1)
  end
end