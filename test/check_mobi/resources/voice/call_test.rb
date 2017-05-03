require 'helper'

describe CheckMobi::Resources::Voice::Call do

  describe 'object buildings test' do
    before do
      @resource = CheckMobi::Resources::Voice::Call.new
      @speak_action = CheckMobi::Resources::Voice::Actions::Speak.new
      @play_action = CheckMobi::Resources::Voice::Actions::Play.new
      @send_dtmf = CheckMobi::Resources::Voice::Actions::SendDTMF.new
      @wait_action = CheckMobi::Resources::Voice::Actions::Wait.new
      @hangup_action = CheckMobi::Resources::Voice::Actions::Hangup.new
    end

    it 'should set default values when not specified' do
      @resource.events.must_equal []
      @resource.platform.must_equal CheckMobi::Configuration::DEFAULT_PLATFORM
    end

    it 'should set events as sent during initialization' do
      resource = CheckMobi::Resources::Voice::Call.new(events: [1])
      resource.events.must_equal [1]
    end

    it 'should set events after initialization' do
      @resource.events << {key: 'value'}
      @resource.events.must_equal [{key: 'value'}]
    end

    it 'should add speak event correctly' do
      @resource.events << @speak_action
      @resource.events.length.must_equal 1
      @resource.events.first.action.must_equal @speak_action.class.name.split('::').last.underscore!
    end

    it 'should add play event correctly' do
      @resource.events << @play_action
      @resource.events.length.must_equal 1
      @resource.events.first.action.must_equal @play_action.class.name.split('::').last.underscore!
    end

    it 'should add send_dtmf event correctly' do
      @resource.events << @send_dtmf
      @resource.events.length.must_equal 1
      @resource.events.first.action.must_equal @send_dtmf.class.name.split('::').last.underscore!
    end

    it 'should add hangup event correctly' do
      @resource.events << @hangup_action
      @resource.events.length.must_equal 1
      @resource.events.first.action.must_equal @hangup_action.class.name.split('::').last.underscore!
    end

    it 'should add wait event correctly' do
      @resource.events << @wait_action
      @resource.events.length.must_equal 1
      @resource.events.first.action.must_equal @wait_action.class.name.split('::').last.underscore!
    end

    it 'should add multiple events correctly' do
      @resource.events << @speak_action
      @resource.events.length.must_equal 1
      @resource.events << @play_action
      @resource.events.length.must_equal 2
      @resource.events << @send_dtmf
      @resource.events.length.must_equal 3
      @resource.events.concat [@hangup_action, @wait_action]
      @resource.events.length.must_equal 5
      @resource.events.each {|event| event.action.must_equal event.class.name.split('::').last.underscore!}
    end

    it 'should have attributes' do
      @resource.must_respond_to :attributes
      @resource.attributes.must_be_instance_of Array
      @resource.attributes.must_include :events
    end

  end


  describe 'api interaction test' do
    before do
      @endpoint = 'https://api.checkmobi.com/v1/call'
      CheckMobi.configure do |c|
        c.api_key = ENV['API_KEY']
      end

      @resource = CheckMobi::Resources::Voice::Call.new(
          to: ENV['PHONE_NUMBER']
      )

      @speak_action = CheckMobi::Resources::Voice::Actions::Speak.new
      @play_action = CheckMobi::Resources::Voice::Actions::Play.new
      @send_dtmf = CheckMobi::Resources::Voice::Actions::SendDTMF.new
      @wait_action = CheckMobi::Resources::Voice::Actions::Wait.new
      @hangup_action = CheckMobi::Resources::Voice::Actions::Hangup.new

      stub_post_request(@endpoint)
    end


    it 'should request without any events' do
      @resource.perform
      assert_requested(:post,
                     @endpoint,
                     headers: headers_with_authorization,
                     body: {from: nil, to: ENV['PHONE_NUMBER'], events: [], notification_callback: nil, platform: 'web'})
    end

    it 'should request with from number' do
      @resource.from = ENV['PHONE_NUMBER']
      @resource.perform
      assert_requested(:post,
                       @endpoint,
                       headers: headers_with_authorization,
                       body: {
                           from: ENV['PHONE_NUMBER'], to: ENV['PHONE_NUMBER'], events: [],
                           notification_callback: nil, platform: 'web'
                       })
    end

    it 'should pass with valid events' do
      @speak_action.update_attributes(text: 'You are the best', loop: 2)
      @play_action.update_attributes(url: 'http://www.tonycuffe.com/mp3/tailtoddle_lo.mp3')
      @send_dtmf.update_attributes(digits: '1W2', async: false)
      @wait_action.length = 4
      speak_action2 = CheckMobi::Resources::Voice::Actions::Speak.new(text: 'We are done.')
      @resource.events << @speak_action << @play_action << @send_dtmf << @wait_action << speak_action2 << @hangup_action
      @resource.perform
      assert_requested(:post,
                       @endpoint,
                       headers: headers_with_authorization,
                       body: {
                           from: nil, to: ENV['PHONE_NUMBER'],
                           notification_callback: nil, platform: 'web',
                           events: [
                           { action: "speak", text: "You are the best", loop: 2, language: "en-US", voice: 'WOMAN' },
                           { action: "play", url: "http://www.tonycuffe.com/mp3/tailtoddle_lo.mp3", loop: 1 },
                           { action: "send_dtmf", digits: "1W2", async: false },
                           { action: "wait", length: 4 },
                           { action: "speak", text: "We are done.", loop: 1, voice: 'WOMAN', language: "en-US" },
                           { action: "hangup", reason: nil }
                           ]
                       })
    end
  end
end