require 'helper'
require 'check_mobi/resources/sms/send'

decribe CheckMobi::Resources::SMS::Send do
  describe 'sms sending should fail' do
    before do
      CheckMobi.configure do |c|
        c.api_key = '123456'
      end
    end

    it 'for invalid api_key' do
      @client = CheckMobi::Resources::SMS::Send.new(to: '+111111111', text: 'hi there!')
      response = @client.perform
      response.code
    end
  end
end