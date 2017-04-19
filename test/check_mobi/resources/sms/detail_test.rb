require 'helper'

describe CheckMobi::Resources::SMS::Details do
  before do
    CheckMobi.configure do |c|
      c.api_key = '123456'
    end
    @resource_class = CheckMobi::Resources::SMS::Details
  end

  describe 'sms details fetching should fail' do
    it 'for invalid api_key' do
      @client = @resource_class.new(id: ENV['SMS_ID'])
      response = @client.perform
      response.status_code.must_equal '401'
    end

    it 'for invalid id' do
      CheckMobi.api_key = ENV['WORKING_API_KEY']
      @client = @resource_class.new(id: nil)
      response = @client.perform
      response.status_code.must_equal '404'
    end

  end

  it 'sms details fetching should be successful' do
    CheckMobi.api_key = ENV['WORKING_API_KEY']
    @client = @resource_class.new(id: ENV['SMS_ID'])
    response = @client.perform
    response.status_code.must_equal '200'
  end
end
