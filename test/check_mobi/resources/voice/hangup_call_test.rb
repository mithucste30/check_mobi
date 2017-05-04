require 'helper'

describe CheckMobi::Resources::Voice::HangupCall do
  before do
    CheckMobi.api_key = ENV['API_KEY']
    @req_id = '1234567890'
    @endpoint = "https://api.checkmobi.com/v1/call/#{@req_id}"
    stub_delete_request(@endpoint)
  end

  it 'should request properly' do
    resource = CheckMobi::Resources::Voice::HangupCall.new(req_id: @req_id)
    resource.perform
    assert_requested(:delete, @endpoint, headers: headers_with_authorization)
  end
end