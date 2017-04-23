require 'helper'

describe CheckMobi::Resources::PhoneValidation::RequestValidation do
  before do
    CheckMobi.configure do |c|
      c.api_key = '123456'
    end

    @resource = CheckMobi::Resources::PhoneValidation::RequestValidation.new(
        phone_number: ENV['PHONE_NUMBER'],
        type: 'cli',
        language: 'en-US'
    )

  end

  describe 'phone validation request should fail' do
    it 'for invalid api_key' do
      response = @resource.perform
      response.status_code.must_equal '401'
    end

    it 'for no phone number' do
      CheckMobi.api_key = ENV['WORKING_API_KEY']
      @resource.phone_number = nil
      response = @resource.perform
      response.status_code.must_equal '400'
    end

    it 'for invalid phone number' do
      CheckMobi.api_key = ENV['WORKING_API_KEY']

      @resource.phone_number = '000000000000'

      response = @resource.perform
      response.status_code.must_equal '400'
    end

    it 'for invalid notification_callback url' do

      CheckMobi.api_key = ENV['WORKING_API_KEY']
      @resource.notification_callback = 'ddddddddd'

      response = @resource.perform
      response.status_code.must_equal '400'
      response.code.must_equal 9
    end

  end

  # it 'phone validation request should be successful' do
  #   CheckMobi.api_key = ENV['WORKING_API_KEY']
  #   @resource.type = 'reverse_cli'
  #   response = @resource.perform
  #   response.status_code.must_equal '200'
  # end
end
