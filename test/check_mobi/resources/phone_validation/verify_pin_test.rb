require 'helper'

describe CheckMobi::Resources::PhoneValidation::VerifyPin do
  before do
    @pin = 'xxxxxx'
    @id = 'sid'
    @endpoint = 'https://api.checkmobi.com/v1/validation/verify'

    CheckMobi.configure do |c|
      c.api_key = ENV['API_KEY']
    end

    @resource = CheckMobi::Resources::PhoneValidation::VerifyPin.new
    stub_post_request(@endpoint)
  end

  it 'validation status resource should request properly' do
    @resource.update_attributes(pin: @pin, id: @id)
    @resource.perform
    assert_requested(:post,
                     @endpoint,
                     body: {pin: @pin, id: @id, use_server_hangup: false},
                     headers: headers_with_authorization,
                     times: 1)
  end

end
