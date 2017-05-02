require 'helper'

describe CheckMobi::Resources::SMS::Send do
  describe 'sms sending should fail' do
    before do
      @endpoint = 'https://api.checkmobi.com/v1/sms/send'
      CheckMobi.api_key = ENV['API_KEY']
      stub_post_request(@endpoint)
    end

    it 'for invalid sender field' do
      text = 'hi there!'
      @client = CheckMobi::Resources::SMS::Send.new(text: text)
      @client.perform
      assert_requested(:post,
                       @endpoint,
                       headers: headers_with_authorization,
                       body: {text: text,
                              to: nil,
                              notification_callback: nil,
                              platform: 'web'
                       },
                       times: 1)
    end


    it 'for invalid text field' do
      @client = CheckMobi::Resources::SMS::Send.new(to: ENV['PHONE_NUMBER'])
      @client.perform
      assert_requested(:post,
                       @endpoint,
                       headers: headers_with_authorization,
                       body: {text: nil,
                              to: ENV['PHONE_NUMBER'],
                              notification_callback: nil,
                              platform: 'web'
                       },
                       times: 1)
    end

    it 'sms sending should be successful' do
      text = 'hi there!'
      @client = CheckMobi::Resources::SMS::Send.new(to: ENV['PHONE_NUMBER'], text: text)
      @client.perform
      assert_requested(:post,
                       @endpoint,
                       headers: headers_with_authorization,
                       body: {text: text,
                              to: ENV['PHONE_NUMBER'],
                              notification_callback: nil,
                              platform: 'web'
                       },
                       times: 1)
    end
  end

end
