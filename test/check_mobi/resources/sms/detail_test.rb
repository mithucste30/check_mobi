require 'helper'

describe CheckMobi::Resources::SMS::Details do
  before do
    @endpoint = "https://api.checkmobi.com/v1/sms/"
    CheckMobi.api_key = ENV['API_KEY']
    @resource_class = CheckMobi::Resources::SMS::Details
    stub_get_request(@endpoint)
    stub_get_request(@endpoint + ENV['SMS_ID'])
  end

  it 'for invalid id' do
    client = @resource_class.new(id: nil)
    client.perform
    assert_requested(:get, @endpoint, headers: headers_with_authorization, times: 1)
  end

  it 'sms details fetching should be successful' do
    client = @resource_class.new(id: ENV['SMS_ID'])
    client.perform
    assert_requested(:get, @endpoint + ENV['SMS_ID'], headers: headers_with_authorization, times: 1)
  end
end
