require 'helper'

describe CheckMobi::Resources::PhoneValidation::RequestValidation do
  before do
    CheckMobi.configure do |c|
      c.api_key = '123456'
    end
    @resource_class = CheckMobi::Resources::PhoneValidation::RequestValidation

  end

  describe 'sms phone validation request should fail' do
    it 'for invalid api_key' do
      @client = @resource_class.new(
         number: ENV['PHONE_NUMBER'],
         type: 'cli',
         language: 'en-US'
      )
      response = @client.perform
      response.status_code.must_equal '401'
    end

    it 'for no phone number' do
      CheckMobi.api_key = ENV['WORKING_API_KEY']
      @client = @resource_class.new(
          number: nil,
          type: 'cli',
          language: 'en-US'
      )
      response = @client.perform
      response.status_code.must_equal '400'
    end

    it 'for invalid phone number' do
      CheckMobi.api_key = ENV['WORKING_API_KEY']
      @client = @resource_class.new(
          number: '000000000000',
          type: 'cli',
          language: 'en-US'
      )
      response = @client.perform
      response.status_code.must_equal '400'
    end

    it 'for invalid notification_callback url' do

      CheckMobi.api_key = ENV['WORKING_API_KEY']

      @client = @resource_class.new(
          number: ENV['PHONE_NUMBER'],
          type: 'cli',
          language: 'en-US',
          notification_callback: 'ddddddddd'
      )
      response = @client.perform
      response.status_code.must_equal '400'
      response.code.must_equal 9
    end

  end

  # it 'sms details fetching should be successful' do
  #   CheckMobi.api_key = ENV['WORKING_API_KEY']
  #   @client = @resource_class.new(
  #       number: ENV['PHONE_NUMBER'],
  #       type: 'cli',
  #       language: 'en-US'
  #   )
  #   response = @client.perform
  #   response.code.must_equal '200'
  # end
end
