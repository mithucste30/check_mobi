require 'helper'

describe CheckMobi::Resources::SMS::Send do
  describe 'sms sending should fail' do
    before do
      CheckMobi.configure do |c|
        c.api_key = '123456'
      end
    end

    it 'for invalid api_key' do
      @client = CheckMobi::Resources::SMS::Send.new(to: '+111111111', text: 'hi there!')
      response = @client.perform
      response.status_code.must_equal '401'
    end

    it 'for invalid sender field' do
      CheckMobi.api_key = ENV['WORKING_API_KEY']
      @client = CheckMobi::Resources::SMS::Send.new(text: 'hi there!')
      response = @client.perform
      response.status_code.must_equal '400'
    end

    it 'for invalid text field' do
      CheckMobi.api_key = ENV['WORKING_API_KEY']
      @client = CheckMobi::Resources::SMS::Send.new(to: ENV['PHONE_NUMBER'])
      response = @client.perform
      response.status_code.must_equal '400'
    end
  end

  # it 'sms sending should be successful' do
  #   CheckMobi.api_key = ENV['WORKING_API_KEY']
  #   @client = CheckMobi::Resources::SMS::Send.new(to: '+8801911255016', text: 'hi there!')
  #   response = @client.perform
  #   response.status_code.must_equal "200"
  # end
end
