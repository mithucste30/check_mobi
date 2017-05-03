require 'helper'

describe CheckMobi::Resources::PhoneValidation::RequestValidation do
  before do
    @endpoint = 'https://api.checkmobi.com/v1/validation/request'

    CheckMobi.configure do |c|
      c.api_key = ENV['API_KEY']
    end

    @resource = CheckMobi::Resources::PhoneValidation::RequestValidation.new(
        number: ENV['PHONE_NUMBER'],
        type: 'cli',
        language: 'en-US'
    )

    stub_post_request(@endpoint)
  end

  describe 'phone validation resource' do

    it 'should request with no phone number' do
      @resource.number = nil
      @resource.perform
      assert_requested(:post,
                       @endpoint,
                       headers: headers_with_authorization,
                       body: { number: nil, type: 'cli', language: 'en-US', notification_callback:nil, platform: "web"},
                       times: 1)
    end

    it 'should request with all valid fields' do
      CheckMobi.api_key = ENV['API_KEY']
      @resource.type = 'reverse_cli'
      @resource.perform
      assert_requested(:post,
                       @endpoint,
                       headers: headers_with_authorization,
                       body: { number: ENV['PHONE_NUMBER'], type: 'reverse_cli', language: 'en-US',
                               notification_callback:nil, platform: "web"},
                       times: 1)
    end

  end


end
