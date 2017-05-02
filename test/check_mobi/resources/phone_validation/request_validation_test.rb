require 'helper'

describe CheckMobi::Resources::PhoneValidation::RequestValidation do
  before do
    @endpoint = 'https://api.checkmobi.com/v1/validation/request'

    CheckMobi.configure do |c|
      c.api_key = '123456'
    end

    @resource = CheckMobi::Resources::PhoneValidation::RequestValidation.new(
        number: ENV['PHONE_NUMBER'],
        type: 'cli',
        language: 'en-US'
    )

    stub_post_request(@endpoint)
  end

  describe 'phone validation request' do

    it 'for no phone number' do
      @resource.number = nil
      response = @resource.perform
      response.status_code.must_equal '400'
    end

    it 'for invalid phone number' do
      @resource.number = '000000000000'

      response = @resource.perform
      response.status_code.must_equal '400'
    end

    it 'for invalid notification_callback url' do

      CheckMobi.api_key = ENV['API_KEY']
      @resource.notification_callback = 'ddddddddd'

      response = @resource.perform
      response.status_code.must_equal '400'
      response.code.must_equal 9
    end

  end

  # it 'phone validation request should be successful' do
  #   CheckMobi.api_key = ENV['API_KEY']
  #   @resource.type = 'reverse_cli'
  #   response = @resource.perform
  #   response.status_code.must_equal '200'
  # end
end
