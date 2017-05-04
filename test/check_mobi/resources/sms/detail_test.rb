require 'helper'

describe CheckMobi::Resources::SMS::Details do
  before do
    @endpoint = "https://api.checkmobi.com/v1/sms/"
    @sms_id = '123456'
    CheckMobi.api_key = ENV['API_KEY']
    @resource_class = CheckMobi::Resources::SMS::Details
    stub_get_request(@endpoint)
    stub_get_request(@endpoint + @sms_id)
  end

  it 'with invalid id' do
    client = @resource_class.new(id: nil)
    client.perform
    assert_requested(:get, @endpoint, headers: headers_with_authorization, times: 1)
  end

  it 'sms details fetching should be successful' do
    client = @resource_class.new(id: @sms_id)
    client.perform
    assert_requested(:get, @endpoint + @sms_id, headers: headers_with_authorization, times: 1)
  end
end
