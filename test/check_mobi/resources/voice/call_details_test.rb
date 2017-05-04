require 'helper'

describe CheckMobi::Resources::Voice::CallDetails do
  before do
    CheckMobi.api_key = ENV['API_KEY']
    @id = '1234567890'
    @endpoint = "https://api.checkmobi.com/v1/call/#{@id}"
    stub_get_request(@endpoint)
  end

  it 'should request properly' do
    resource = CheckMobi::Resources::Voice::CallDetails.new(id: @id)
    resource.perform
    assert_requested(:get, @endpoint, headers: headers_with_authorization)
  end
end